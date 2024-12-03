extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Swap out the cubes that the cube controllers are using.
	swap_cubes()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
 

# This function just sets different cubes for all the cube controllers to control.
func swap_cubes():
	# Go through each cube controller and change its cube out for a secondary cube.
	$CubeControllerF2L.change_cube($F2LCube)
	$CubeControllerOLL1.change_cube($OLL1Cube)
	$CubeControllerOLL2.change_cube($OLL2Cube)
	$CubeControllerPLL1.change_cube($PLL1Cube1)
	$CubeControllerPLL2.change_cube($PLL2Cube1)
