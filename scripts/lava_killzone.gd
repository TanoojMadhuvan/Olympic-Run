
#This script makes it so that players die when they touch lava

extends StaticBody3D
@onready var area_3d = $Area3D
@onready var timer = $Timer

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Check for other players that touch lava
	for body in area_3d.get_overlapping_bodies() :
		body.position = body.spawnpoint;	

func _on_timer_timeout():
	Engine.time_scale = 1;
	get_tree().reload_current_scene()		

