#This simple script allows a player to set their settings to change their mouse sensitivity

extends LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_submitted(new_text):
	if int(new_text) != 0:
		Transition.mouse = clamp(int(new_text), 1, 100)
		print(Transition.mouse)


func _on_text_changed(new_text):
	pass # Replace with function body.
