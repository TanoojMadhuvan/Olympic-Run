#This script allows the dissolve animation to play between a transition between two scenes

extends CanvasLayer
@onready var ani = $AnimationPlayer
var time = 0
var mouse = 50
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_scene_to_file(target: String):
	#Playing the dissolve animation, changing the scene, and reversing the dissolve to show new scene
	ani.play('dissolve')
	await ani.animation_finished
	get_tree().change_scene_to_file(target)
	ani.play_backwards('dissolve')
	
