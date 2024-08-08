extends StaticBody3D
@onready var area_3d = $Area3D
@export var boost = 50;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in area_3d.get_overlapping_bodies() :
		body.SPEED = boost;
		
	

