extends Node3D

# This list will hold the list of moves that the cube will be doing.
@export var ALGORITHM = []
# This number will be how long (in seconds) each turn will take to make. It can be changed in the settings UI.
@export var TIME_PER_TURN = 0.44
# This variable will store the path of the cube that is being controlled by this node.
var CONNECTED_CUBE
# This bool keeps track of whether the cube is simulating an algorithm or remaining stagnant.
var IS_CONTROLLER_RUNNING: bool = false
# This number keeps track of what move we're on in the algorithm. It resets to 0 when a new cycle starts.
var MOVE_NUMBER = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set the cube path up.
	CONNECTED_CUBE = $Cube


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# If the controller is running and the timer is not running, then it's time to start a new turn and the timer again.
	if IS_CONTROLLER_RUNNING == true and $TurnTimer.is_stopped() == true:
		start_next_turn()
		$TurnTimer.start(TIME_PER_TURN + 0.1)


# This function is used to start/unpause the cube's turning simulation.
func start_simulation():
	# Change the bool to indicate the the cube is now simulating an algorithm.
	IS_CONTROLLER_RUNNING = true
	# Start/restart the turn timer.
	$TurnTimer.paused = false


# This function is used to stop/pause the cube's turning simulation.
func stop_simulation():
	# Change the bool to indicate the cube is no longer simulating an algorithm.
	IS_CONTROLLER_RUNNING = false
	# Pause/stop the turn timer.
	$TurnTimer.paused = true


# This function starts a new turn.			# Next order of business is making it so there is an option for the cube animation to do the same alg over and over without resetting the cube.
func start_next_turn():
	# Check to see if the last move was the last move in the algorithm.
	if MOVE_NUMBER >= ALGORITHM.size():
		# The last move was the last move. reset the move number variable.
		MOVE_NUMBER = 0
		# Reset the connected cube to be solved.
		CONNECTED_CUBE.reset()
	else:
		# The last move was not the last move, so start the next turn.
		CONNECTED_CUBE.call(ALGORITHM[MOVE_NUMBER])
		# Increase the move count by 1.
		MOVE_NUMBER += 1
		

# This function changes the cube that the cube controller is controlling. (Used when you don't want a standard cube.)
func change_cube(new_cube):
	# Disconnect and delete the current cube first.
	CONNECTED_CUBE.queue_free()
	# Remove the given cube from its parent then add it as a child to this controller.
	new_cube.get_parent().remove_child(new_cube)
	add_child(new_cube)
	# Now set the CONNECTED_CUBE to be the new cube.
	CONNECTED_CUBE = new_cube
