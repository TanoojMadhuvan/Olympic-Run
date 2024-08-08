#This script handles what is shown on the podium screen after the player finishes the game

extends Control

#These are the messages shown on the screen
@onready var mes = $Podium_Finish_Text
@onready var mess = $Podium_Text


# Called when the node enters the scene tree for the first time.
func _ready():
	#The names of the gods, and the times they finish are given in increasing order
	var gods = ["No one", "Hermes", "Poseidon", "Athena", "Zeus", "Artemis", "Ares", "Apollo", "Hera", "Demeter", "Aphrodite", "Hephaestus", "Dionysus", "No one"]
	var times = [7180, 7614, 7891, 8292, 8227, 8281, 8554, 9812, 10014, 11595, 12000, 16633]
	
	#Using a search algorithm to find where the player placed relative to the opponents
	var pos = 0
	for i in range(12):
		if(Transition.time < times[pos]):
			break;
		pos = pos + 1
	
	#Setting the text to the player's placement
	mes.set_text("You finished #" + str(pos + 1))
	mess.set_text("Preceded by: " + gods[pos] + "\nFollowed by: " + gods[pos + 1])
	print(str(pos + 1))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
