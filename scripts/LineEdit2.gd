#This simple script allows a player to set their settings to reduce their speed
#Especially useful if the player is a beginner and the game is too fast

extends LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_submitted(new_text):
	if int(new_text) != 0:
		Transition.speed = clamp(int(new_text), 1, 100)
		print(Transition.speed)
