extends Node3D

# This variable lets you control how fast the children nodes will be rotating. (1 is slow speed and 5 is fast one.)
@export var TURN_SPEED = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# iterate through each child node (cube).
	for puzzle in get_children():
		# Rotate the puzzle around the y axis.
		puzzle.rotation.y += delta * TURN_SPEED
