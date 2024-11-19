extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$LeftCubeController.ALGORITHM = ["Z_CCW", "R", "U", "R_CCW", "U_CCW", "R2", "U2", "F", "B", "F_CCW", "B_CCW", "F2", "B2", "L", "D", "L_CCW", "D_CCW", "L2", "D2", "X_CCW"]
	##$LeftCubeController.ALGORITHM = ["R", "U", "R_CCW", "U_CCW", "R", "U", "R_CCW", "U_CCW", "R", "U", "R_CCW", "U_CCW", "R", "U", "R_CCW", "U_CCW", "R", "U", "R_CCW", "U_CCW", "R", "U", "R_CCW", "U_CCW"]
	#$RightCubeController.ALGORITHM = ["Y2", "F", "R", "U_CCW", "R_CCW", "U_CCW", "R", "U", "R_CCW", "F_CCW", "R", "U", "R_CCW", "U_CCW", "R_CCW", "F", "R", "F_CCW"]
	#$RightCubeController.ALGORITHM = ["Y", "R", "U", "R_CCW", "U_CCW", "X_CCW"]
	$RightCubeController.ALGORITHM = ["Z2", "X", "Y_CCW", "Z2", "X", "Y_CCW", "Z2", "X", "Y_CCW", "Z2", "X", "Y_CCW", "Z2", "X", "Y_CCW"]
	
	$LeftCubeController.start_simulation()
	$RightCubeController.start_simulation()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_tester_timer_timeout():
	pass
	
# Broken functions:   X2, X_CCWhoow, Y2, Z_CCW, Z2
# Working functions: X
