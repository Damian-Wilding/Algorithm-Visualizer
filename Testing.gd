extends Node3D

var piece
var piece2
var piece3
var iterator = 10.0
#var rotation_speed = 2
var location
var time_to_turn = .1
var place_to_rotate_to = 0
var place_to_rotate_to2 = 0
var place_to_rotate_to3 = - PI / 2
var speed_multiplier = 10
var a_dictionary = {"ItalianCorner": {"X": 1, "Y": 2, "Z": 0}, "IrishCorner": {"X": 4, "Y": 5, "Z": 6}}

# Called when the node enters the scene tree for the first time.
func _ready():
	piece = $Cube/WhiteCenter
	piece2 = $Cube/WG
	piece3 = $Cube/ItalianCorner
	$Cube.remove_child(piece)
	$Cube.remove_child(piece2)
	$Cube.remove_child(piece3)
	$Cube/TurningSide.add_child(piece)
	$Cube/TurningSide.add_child(piece2)
	$Cube/TurningSide.add_child(piece3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	if $TesterTimer.is_stopped() != true:
		$Cube/TurningSide.rotation.y += .01
	else:
		$Cube/TurningSide.rotation.x += 0.01		
	


func _on_tester_timer_timeout():
	pass
	
