#This script allows a player to change their scene when a button is pressed

extends Button
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Transition.change_scene_to_file("res://scenes/menu.tscn")
