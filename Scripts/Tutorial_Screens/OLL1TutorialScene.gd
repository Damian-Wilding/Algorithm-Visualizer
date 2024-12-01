extends Node3D

# This list contains all the controllers in it.
var CONTROLLERS = []
# This bool keeps track of whether the pause menu is open or not.
var IS_PAUSE_MENU_ACTIVE: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Add all the cube controllers to the cube controllers list.
	for controller in get_tree().get_nodes_in_group("Controllers"):
		CONTROLLERS.append(controller)
	# Change the cubes being used by the cube controllers.
	change_cubes()
	# Give the cube controllers default algorithms.
	$CubeController1.ALGORITHM = ["F", "R", "U", "R_CCW", "U_CCW", "F_CCW"]
	$CubeController2.ALGORITHM = ["F", "R", "U", "R_CCW", "U_CCW", "F_CCW", "U2", "F", "U", "R", "U_CCW", "R_CCW", "F_CCW"]
	$CubeController3.ALGORITHM = ["F", "U", "R", "U_CCW", "R_CCW", "F_CCW"]
	# Start all the cube controllers.
	for controller in CONTROLLERS:
		controller.start_simulation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Check to see if the esc key has been pressed.
	if Input.is_action_just_pressed("ui_cancel"):
		# Toggle the pause menu.
		toggle_pause_simulation()


# This function toggles the pause menu. It either opens or closes it.
func toggle_pause_simulation():
	# Check if the pause menu is not already open.
	if IS_PAUSE_MENU_ACTIVE == false:
		# The pause menu isn't active so add it to the scene.
		var pause_menu_instance = load("res://Scenes/pause_menu.tscn").instantiate()
		add_child(pause_menu_instance)
		# Toggle IS_PAUSE_MENU_ACTIVE.
		IS_PAUSE_MENU_ACTIVE = true
		# Pause all the cube controllers.
		for controller in CONTROLLERS:
			controller.stop_simulation()
	else:	
		# The pause menu is already active so remove it.
		$PauseMenu.queue_free()
		# Toggle IS_PAUSE_MENU_ACTIVE.
		IS_PAUSE_MENU_ACTIVE = false
		# Unpause all the cube controllers.
		for controller in CONTROLLERS:
			controller.start_simulation()


# This function is used to switch the cubes being used in each cube controller. (It will be different in every scene.)
func change_cubes():
	# Change each cube for each of the cube controllers.
	$CubeController1.change_cube($OLL1LeftCube)
	$CubeController2.change_cube($OLL1CenterCube)
	#$CubeController3.change_cube($OLL1RightCube)
