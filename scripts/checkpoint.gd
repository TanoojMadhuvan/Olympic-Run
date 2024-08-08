#This script was coded to make it so that touching checkpoints changes the player's spawnpoint 

extends StaticBody3D

var index = 0

#All the locations where the checkpoints will be
var positions = [Vector3(40.906,6.562, 19.031), Vector3(42.322,-25.949, 120.566), Vector3(148.657,-56.623, 52.864), Vector3(159.35, -244.618, -69.566), Vector3(133.414,-286.272, -232.255), Vector3(-64.249, -286.272, -232.255), Vector3(-91.364, -302.384, -99.432), Vector3(-11.364, 8.368, -69.432)]

#Used to at what time the player finishes the game, to determine placement
var time = 0
@onready var area_3d = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	position = positions[index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time = time + 1			

#Checking if player enters checkpoint
func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		
		#Reset the spawn position
		body.spawnpoint.x = positions[index].x
		body.spawnpoint.y = positions[index].y
		body.spawnpoint.z = positions[index].z
		index += 1
		
		#Find out if it is a checkpoint, or if it is actually the finish-line checkpoint
		if index < positions.size():
			position = positions[index]
		else:
			#When reaching finish-line, change scene and store the finish time
			Transition.time = time
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Transition.change_scene_to_file("res://scenes/podium.tscn")
