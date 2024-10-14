extends Node3D

var POSITION_SCALER = 3
# Degrees to rotate is how many degrees the current turn being made is rotating. (In other words, if I'm currently in the middle of a 90 degree turn, then degrees to rotate will be 90.)
var DEGREES_TO_ROTATE = 90
# Turn speed is how fast the cube will turn. (5.00 is the slowest (1 turn every 5 seconds) and 0.1 is the fastest (10 turns per second).)
var TURN_SPEED = 1
# This controls how long it takes the cube to rotate 90 degrees. (Time in seconds.)
var TIME_TO_TURN = 1.01
# This list is going to contain all of the pieces of the cube. (It's empty here, but the pieces will be added in _ready().)
var ALL_PIECES_LIST = []
# This list is going to contain all of the pieces that are currently moving.
var CURRENTLY_MOVING_PIECES = []
# This variable keeps track of whether the cube is able to be turned or not. (It starts off as false, then when a key is pressed, it will change to be true and once the key is released, it will change back to false. I'm mainly just using this to debug this script.)
var CANT_BE_TURNED = true
# This variable will tell the cube which axis to rotate on. ( U() would be "Y", D() would be "-Y", F() would be "Z", B() would be "-Z", etc...)
var CURRENT_AXIS_OF_ROTATION
# These variables are used to set the rotation velocity of the currently turning parts.
var X_AXIS_ROTATIONAL_VELOCITY = 0
var Y_AXIS_ROTATIONAL_VELOCITY = 0
var Z_AXIS_ROTATIONAL_VELOCITY = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make a list with every piece of the cube in it. (This is used for debugging and cube rotations.)
	# First add the corners to the list.
	for corner in $Corners.get_children():
		ALL_PIECES_LIST.append(corner.get_child(0).get_child(0))
	# Then add the edges.
	for edge in $Edges.get_children():
		ALL_PIECES_LIST.append(edge.get_child(0).get_child(0))
	# Then add the centers.
	for center in $Centers.get_children():
		ALL_PIECES_LIST.append(center.get_child(0).get_child(0))
	# Finally, add the core.
	ALL_PIECES_LIST.append($Core/MeshInstance3D)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		U()
				
	elif Input.is_action_just_released("ui_text_caret_down"):
		F()
	
	# Have the cube continue to rotate if the timer is running.
	if $HowLongToTurn90Degrees.is_stopped() == false:
		# Iterate through all the pieces that need to be turned.
		for piece in CURRENTLY_MOVING_PIECES:
			# Rotate the pieces based on the axis rotational velocities.
			#if CURRENT_AXIS_OF_ROTATION == "Y":
			#	get_node("Cube").get_node("Corners").get_node(piece).rotation.y = lerp_angle(get_node("Cube").get_node("Corners").get_node(piece).rotation.y, deg_to_rad(DEGREES_TO_ROTATE), delta * deg_to_rad(DEGREES_TO_ROTATE) * TURN_SPEED)
			#elif CURRENT_AXIS_OF_ROTATION == "X":
			#	piece.rotation.x = lerp_angle(piece.rotation.x, deg_to_rad(DEGREES_TO_ROTATE), delta * deg_to_rad(DEGREES_TO_ROTATE) * TURN_SPEED)
			#elif CURRENT_AXIS_OF_ROTATION == "Z":
			#	piece.rotation.z = lerp_angle(piece.rotation.z, deg_to_rad(DEGREES_TO_ROTATE), delta * deg_to_rad(DEGREES_TO_ROTATE) * TURN_SPEED)
			#print(piece)
			pass


# This function currently isn't being used. I decided to have cube logic do this instead since I couldn't make this one work correctly.
# This function will return a list of all the pieces on a selected side. It takes the name of the side as an argument. ("Top", "Left", "Front", "Right", "Back", "Down")
func get_pieces_on_side(side):
	# Make a list that will be returned at the end of the function.
	var pieces_list = []
	# Figure out what side is being used.
	match side:
		"Top":
			# Check all corners and see if they're on the top side.
			for corner in $Corners.get_children():
				#print(corner.name)
				#print(corner.get_child(0).get_child(0).rotation)
				#print(corner.get_child(0).rotation)
				#print(corner.rotation)
				if corner.get_child(0).get_child(0).position.y == POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the top side.
			for edge in $Edges.get_children():
				if edge.get_child(0).get_child(0).position.y == POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the top side.
			for center in $Centers.get_children():
				if center.get_child(0).get_child(0).position.y == POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list
	# Figure out what side is being used.
	match side:
		"Left":
			# Check all corners and see if they're on the left side.
			for corner in $Corners.get_children():
				if corner.get_child(0).get_child(0).position.x == -POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the left side.
			for edge in $Edges.get_children():
				if edge.get_child(0).get_child(0).position.x == -POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the left side.
			for center in $Centers.get_children():
				if center.get_child(0).get_child(0).position.x == -POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list
	# Figure out what side is being used.
	match side:
		"Front":
			# Check all corners and see if they're on the front side.
			for corner in $Corners.get_children():
				if corner.get_child(0).get_child(0).position.z == POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the front side.
			for edge in $Edges.get_children():
				if edge.get_child(0).get_child(0).position.z == POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the front side.
			for center in $Centers.get_children():
				if center.get_child(0).get_child(0).position.z == POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list
	# Figure out what side is being used.
	match side:
		"Right":
			# Check all corners and see if they're on the right side.
			for corner in $Corners.get_children():
				if corner.get_child(0).get_child(0).position.x == POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the right side.
			for edge in $Edges.get_children():
				if edge.get_child(0).get_child(0).position.x == POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the right side.
			for center in $Centers.get_children():
				if center.get_child(0).get_child(0).position.x == POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list
	# Figure out what side is being used.
	match side:
		"Back":
			# Check all corners and see if they're on the back side.
			for corner in $Corners.get_children():
				if corner.get_child(0).get_child(0).position.z == -POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the back side.
			for edge in $Edges.get_children():
				if edge.get_child(0).get_child(0).position.z == -POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the back side.
			for center in $Centers.get_children():
				if center.get_child(0).get_child(0).position.z == -POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list
	# Figure out what side is being used.
	match side:
		"Down":
			# Check all corners and see if they're on the bottom side.
			for corner in $Corners.get_children():
				if corner.get_child(0).get_child(0).position.y == -POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the bottom side.
			for edge in $Edges.get_children():
				if edge.get_child(0).get_child(0).position.y == -POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the bottom side.
			for center in $Centers.get_children():
				if center.get_child(0).get_child(0).position.y == -POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list


# The following lines are code for each individual turn/rotation the cube can make.

# Turn the top face clockwise.
func U():
	# Only do this if the cube isn't currently turning already.
	if $TurnTimer.is_stopped():
		# Update cube logic.
		$CubeLogic.U()
		# Change DEGREES_TO_TURN to be 270 since this is a -90 degree turn. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns.)
		DEGREES_TO_ROTATE += 270
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Start the turn timer. (It tells us how long we want the turn to take.)
		$HowLongToTurn90Degrees.start(TURN_SPEED)
		# Clear all previous pieces from the currently moving parts list.
		CURRENTLY_MOVING_PIECES.clear()
		# Find all the pieces on the top face and add them to the currently moving parts list.
		CURRENTLY_MOVING_PIECES = $CubeLogic.find_pieces_in_layer("U")
		for thing  in CURRENTLY_MOVING_PIECES:
			print(thing.name)

# Turn the top face counter clockwise.
func U_CCW():
	# Update cube logic.
	$CubeLogic.U_CCW()
	
# Turn the top face 180 degrees.
func U2():
	# Update cube logic.
	$CubeLogic.U2()

# Turn the bottom face clockwise.
func D():
	# Update cube logic.
	$CubeLogic.D()

# Turn the bottom face counter clockwise.
func D_CCW():
	# Update cube logic.
	$CubeLogic.D_CCW()

# Turn the bottom face 180 degrees.
func D2():
	# Update cube logic.
	$CubeLogic.D2()

# Turn the front face clockwise.
func F():
	# Only do this if the cube isn't currently turning already.
	if $TurnTimer.is_stopped():
		# Update cube logic.
		$CubeLogic.F()
		# Change DEGREES_TO_TURN to be 270 since this is a -90 degree turn. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns.)
		DEGREES_TO_ROTATE += 270
		# Update the axis that the pieces will be turning around.
		change_axis("Z")
		# Start the turn timer. (It tells us how long we want the turn to take.)
		$HowLongToTurn90Degrees.start(TURN_SPEED)
		# Clear all previous pieces from the currently moving parts list.
		CURRENTLY_MOVING_PIECES.clear()
		# Find all the pieces on the front face and add them to the currently moving parts list.
		CURRENTLY_MOVING_PIECES = $CubeLogic.find_pieces_in_layer("F")
	
# Turn the front face counter clockwise.
func F_CCW():
	# Update cube logic.
	$CubeLogic.F_CCW()

# Turn the front face 180 degrees.
func F2():
	# Update cube logic.
	$CubeLogic.F2()

# Turn the back face clockwise.
func B():
	# Update cube logic.
	$CubeLogic.B()

# Turn the back face counter clockwise.
func B_CCW():
	# Update cube logic.
	$CubeLogic.B_CCW()

# Turn the back face 180 degrees.
func B2():
	# Update cube logic.
	$CubeLogic.B2()

# Turn the right face clockwise.
func R():
	# Update cube logic.
	$CubeLogic.R()

# Turn the right face counter clockwise.
func R_CCW():
	# Update cube logic.
	$CubeLogic.R_CCW()

# Turn the right face 180 degrees.
func R2():
	# Update cube logic.
	$CubeLogic.R2()

# Turn the left face clockwise.
func L():
	# Update cube logic.
	$CubeLogic.L()

# Turn the left face counter clockwise.
func L_CCW():
	# Update cube logic.
	$CubeLogic.L_CCW()

# Turn the left face 180 degrees.
func L2():
	# Update cube logic.
	$CubeLogic.L2()


# Rotate the entire cube clockwise along the x axis.
func X():
	# Update cube logic.
	$CubeLogic.X()
	
# Rotate the entire cube counter clockwise along the X axis.
func X_CCW():
	# Update cube logic.
	$CubeLogic.X_CCW()
	
# Rotate the entire cube 180 degrees along the x axis.
func X2():
	# Update cube logic.
	$CubeLogic.X2()
	
# Rotate the entire cube clockwise along the y axis.
func Y():
	# Update cube logic.
	$CubeLogic.Y()
	
# Rotate the entire cube counter clockwise along the y axis.
func Y_CCW():
	# Update cube logic.
	$CubeLogic.Y_CCW()
	
# Rotate the entire cube 180 degrees along the y axis.
func Y2():
	# Update cube logic.
	$CubeLogic.Y2()
	
# Rotate the entire cube clockwise along the z axis.
func Z():
	# Update cube logic.
	$CubeLogic.Z()
	
# Rotate the entire cube counter clockwise along the z axis.
func Z_CCW():
	# Update cube logic.
	$CubeLogic.Z_CCW()
	
# Rotate the entire cube 180 degrees along the z axis.
func Z2():
	# Update cube logic.
	$CubeLogic.Z2()


func TestingTimer_on_timer_timeout():
	#U()
	pass


# This function will change the axis that all the moving pieces will be moving around.
func change_axis(axis):
	CURRENT_AXIS_OF_ROTATION = axis
