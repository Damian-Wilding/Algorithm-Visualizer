extends Node3D

var STICKER_COLOR = "Null"
var LAST_STICKER_COLOR = "Null"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Change the color of the sticker.
func change_color(color):
	STICKER_COLOR = color

# Get the previous sticker color.
func get_previous_color():
	return LAST_STICKER_COLOR
	print("Last sticker color was: ." + LAST_STICKER_COLOR)
	
# Get the current sticker color.
func get_sticker_color():
	return STICKER_COLOR
	print("The current sticker color is: " + STICKER_COLOR)
