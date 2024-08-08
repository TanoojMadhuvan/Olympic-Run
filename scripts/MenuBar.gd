#This script is not actually used in the game, it was for testing

extends MenuBar

# Called when the node enters the scene tree for the first time.
func _ready():
	get_menu_popup().add_item("Low")
	get_menu_popup().add_item("Medium")
	get_menu_popup().add_item("High")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
