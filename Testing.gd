extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$LeftCubeController.ALGORITHM = ["R", "U", "R_CCW", "U_CCW", "R", "U", "R_CCW", "U_CCW", "R", "U", "R_CCW", "U_CCW", "R", "U", "R_CCW", "U_CCW", "R", "U", "R_CCW", "U_CCW", "R", "U", "R_CCW", "U_CCW"]
	$RightCubeController.ALGORITHM = ["F", "R", "U_CCW", "R_CCW", "U_CCW", "R", "U", "R_CCW", "F_CCW", "R", "U", "R_CCW", "U_CCW", "R_CCW", "F", "R", "F_CCW"]
	
	$LeftCubeController.start_simulation()
	$RightCubeController.start_simulation()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_tester_timer_timeout():
	pass
	
