extends Node3D

var piece
var piece2
var piece3
var iterator = 10.0
#var rotation_speed = 2
var location
var time_to_turn = .1
var speed_multiplier = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$LeftCubeController.connect_to_cube($LeftCube)
	$LeftCubeController.ALGORITHM = ["R", "U", "R_CCW", "U_CCW"]

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	


func _on_tester_timer_timeout():
	pass
	
