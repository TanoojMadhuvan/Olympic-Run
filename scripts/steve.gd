extends CharacterBody3D


var SPEED = 20.0
var TERMINAL_SPEED = 20.0
const ROTSPEED = 0.2;
const JUMP_VELOCITY = 15
const PUSH_FORCE = 0.2

var MOUSE_SENSITIVITY := 0.005

@onready var rigid_body_3d = $"../RigidBody3D"
@onready var camera = $XRCamera3D


@onready var lava = $"../lava"

var spawnpoint = Vector3(0,0,0);

func _ready() -> void:
	MOUSE_SENSITIVITY *= Transition.mouse / 50.0
	SPEED *= Transition.speed / 100.0
	TERMINAL_SPEED *= Transition.speed / 100.0
	
	var mesh = $MeshInstance3D;
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	spawnpoint = position
	#var i = [-92.7349700927734, -297.852813720703, -162.797225952148,   -0, 1.58181488513947, 0,   -0.56345039606094, 1.60534167289734, 2.12762308120728]
	#position.x = i[0]
	#position.y = i[1]
	#position.z = i[2]
	#rotation.x = i[3]
	#rotation.y = i[4]
	#rotation.z = i[5]
	#mesh.rotation.x = i[6]
	#mesh.rotation.y = i[7]
	#mesh.rotation.z = i[8]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")



func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.offset.y += event.relative.y * MOUSE_SENSITIVITY * 3;
		camera.offset.y = clamp(camera.offset.y, 1, 10);
		


func _physics_process(delta):
	
	var mesh = $MeshInstance3D;
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Transition.change_scene_to_file("res://scenes/menu.tscn")	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("forward", "backward", "strafe-right", "strafe-left")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if(Input.is_action_pressed("forward")):
		mesh.rotate_z(ROTSPEED);
	if(Input.is_action_pressed("backward")):
		mesh.rotate_z(-ROTSPEED);
	if(Input.is_action_pressed("strafe-left")):
		mesh.rotate_x(ROTSPEED);
		direction/=2
	if(Input.is_action_pressed("strafe-right")):
		mesh.rotate_x(-ROTSPEED);
		direction/=2
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	else:
		velocity.x /= 1.1
		velocity.z /= 1.1
		
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	var normal = Vector3.ZERO

	if is_on_floor():
		normal = get_floor_normal()

	normal.y = -normal.y

	velocity += normal
	
	move_and_slide()
	
	if Input.is_action_just_pressed("restart") or position.y < -400:
		position = spawnpoint
		print("Breakpoint")
	
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			if direction:
				c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.z = move_toward(velocity.z, 0, SPEED)
				
		
	if SPEED > TERMINAL_SPEED:
		SPEED -= 1
	
	
	#print("["+str(position.x)+", "+str(position.y)+", "+str(position.z)+",   "+str(rotation.x)+", "+str(rotation.y)+", "+str(rotation.z)+",   "+str(mesh.rotation.x)+", "+str(mesh.rotation.y)+", "+str(mesh.rotation.z)+"],")
