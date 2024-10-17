extends Node3D

# RADIANS_TO_ROTATE is a dictionary that keeps track of the rotation of each of the 6 layers. (During a normal move, only one of these values will change by 90, 180, or -90 degrees.)
var RADIANS_TO_ROTATE = {"U": 0, "L": 0, "F": 0, "R": 0, "B": 0, "D": 0}
# CURRENTLY_ROTATING_LAYER keeps track of what layer is currently being turned. 
var CURRENTLY_ROTATING_LAYER
# This variable is the absolute value of the degrees to rotate. It is used to calculate the turn speed. This is needed because if the DEGREES_TO_ROTATE is negative then it will not work correctly. Basically, if DEGREES_TO_ROTATE is -270, then this will be +90 since it is a 90 degree turn and using -270 to calculate the turning speed would break everything.
#var ABSOLUTE_VALUE_DEGREES_TO_ROTATE = 90
# TURN_TIMER_MULTIPLIER alters how fast the cube will turn. (A higher number means a faster turn and a lower number means a slower turn. If you change TIME_TO_TURN, then this will probably need to be changed too because the cube won't be moving fast enough to complete turns in time.)
var TURN_TIMER_MULTIPLIER = 10
# This controls how long the cube can't be turned for while a turn is being made. (Time in seconds.)
var TIME_TO_TURN = 0.50
# This number keeps track of how much time has passed since the current turn started. (It starts off at 10 so you can make turns immediately.)
var ELAPSED_TIME = 10.0
# This list is going to contain all of the pieces of the cube. (It's empty here, but the pieces will be added in _ready().)
var ALL_PIECES_LIST = []
# This list is going to contain all of the pieces that are currently moving.
var CURRENTLY_MOVING_PIECES = []
# This variable keeps track of whether the cube is able to be turned or not. (It starts off as false, then when a key is pressed, it will change to be true and once the key is released, it will change back to false. I'm mainly just using this to debug this script.)
#var ABLE_TO_BE_TURNED = true
# This variable will tell the cube which axis to rotate on. ( U() would be "Y", D() would be "-Y", F() would be "Z", B() would be "-Z", etc...)
var CURRENT_AXIS_OF_ROTATION


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
		R()
	
	# Have the cube continue to rotate if the timer is running.
	if ELAPSED_TIME < TIME_TO_TURN:
		# Add the time that has passed since the last frame to the ELAPSED_TIME variable.
		ELAPSED_TIME += delta
		# Iterate through all the pieces that need to be turned.
		for piece in CURRENTLY_MOVING_PIECES:
			# Rotate the pieces based on the axis rotational velocities.
			print(piece)
			if CURRENT_AXIS_OF_ROTATION == "Y":
				piece.global_rotation.y = lerp_angle(piece.global_rotation.y, RADIANS_TO_ROTATE[CURRENTLY_ROTATING_LAYER], delta * TURN_TIMER_MULTIPLIER)
			elif CURRENT_AXIS_OF_ROTATION == "X":
				piece.global_rotation.x = lerp_angle(piece.global_rotation.x, RADIANS_TO_ROTATE[CURRENTLY_ROTATING_LAYER], delta * TURN_TIMER_MULTIPLIER)
			elif CURRENT_AXIS_OF_ROTATION == "Z":
				piece.global_rotation.z = lerp_angle(piece.global_rotation.z, RADIANS_TO_ROTATE[CURRENTLY_ROTATING_LAYER], delta * TURN_TIMER_MULTIPLIER)
			

# This function currently isn't being used. I decided to have cube logic do this instead since I couldn't make this one work correctly.
# This function will return a list of all the pieces on a selected side. It takes the name of the side as an argument. ("Top", "Left", "Front", "Right", "Back", "Down")
#func get_pieces_on_side(side):
#	# Make a list that will be returned at the end of the function.
#	var pieces_list = []
#	# Figure out what side is being used.
#	match side:
#		"Top":
#			# Check all corners and see if they're on the top side.
#			for corner in $Corners.get_children():
#				#print(corner.name)
#				#print(corner.get_child(0).get_child(0).rotation)
#				#print(corner.get_child(0).rotation)
#				#print(corner.rotation)
#				if corner.get_child(0).get_child(0).position.y == POSITION_SCALER:
#					pieces_list.append(corner)
#			# Check all edges and see if they're on the top side.
#			for edge in $Edges.get_children():
#				if edge.get_child(0).get_child(0).position.y == POSITION_SCALER:
#					pieces_list.append(edge)
#			# Check all centers and see if they're on the top side.
#			for center in $Centers.get_children():
#				if center.get_child(0).get_child(0).position.y == POSITION_SCALER:
#					pieces_list.append(center)
#			return pieces_list
#	# Figure out what side is being used.
#	match side:
#		"Left":
#			# Check all corners and see if they're on the left side.
#			for corner in $Corners.get_children():
#				if corner.get_child(0).get_child(0).position.x == -POSITION_SCALER:
#					pieces_list.append(corner)
#			# Check all edges and see if they're on the left side.
#			for edge in $Edges.get_children():
#				if edge.get_child(0).get_child(0).position.x == -POSITION_SCALER:
#					pieces_list.append(edge)
#			# Check all centers and see if they're on the left side.
#			for center in $Centers.get_children():
#				if center.get_child(0).get_child(0).position.x == -POSITION_SCALER:
#					pieces_list.append(center)
#			return pieces_list
#	# Figure out what side is being used.
#	match side:
#		"Front":
#			# Check all corners and see if they're on the front side.
#			for corner in $Corners.get_children():
#				if corner.get_child(0).get_child(0).position.z == POSITION_SCALER:
#					pieces_list.append(corner)
#			# Check all edges and see if they're on the front side.
#			for edge in $Edges.get_children():
#				if edge.get_child(0).get_child(0).position.z == POSITION_SCALER:
#					pieces_list.append(edge)
#			# Check all centers and see if they're on the front side.
#			for center in $Centers.get_children():
#				if center.get_child(0).get_child(0).position.z == POSITION_SCALER:
#					pieces_list.append(center)
#			return pieces_list
#	# Figure out what side is being used.
#	match side:
#		"Right":
#			# Check all corners and see if they're on the right side.
#			for corner in $Corners.get_children():
#				if corner.get_child(0).get_child(0).position.x == POSITION_SCALER:
#					pieces_list.append(corner)
#			# Check all edges and see if they're on the right side.
#			for edge in $Edges.get_children():
#				if edge.get_child(0).get_child(0).position.x == POSITION_SCALER:
#					pieces_list.append(edge)
#			# Check all centers and see if they're on the right side.
#			for center in $Centers.get_children():
#				if center.get_child(0).get_child(0).position.x == POSITION_SCALER:
#					pieces_list.append(center)
#			return pieces_list
#	# Figure out what side is being used.
#	match side:
#		"Back":
#			# Check all corners and see if they're on the back side.
#			for corner in $Corners.get_children():
#				if corner.get_child(0).get_child(0).position.z == -POSITION_SCALER:
#					pieces_list.append(corner)
#			# Check all edges and see if they're on the back side.
#			for edge in $Edges.get_children():
#				if edge.get_child(0).get_child(0).position.z == -POSITION_SCALER:
#					pieces_list.append(edge)
#			# Check all centers and see if they're on the back side.
#			for center in $Centers.get_children():
#				if center.get_child(0).get_child(0).position.z == -POSITION_SCALER:
#					pieces_list.append(center)
#			return pieces_list
#	# Figure out what side is being used.
#	match side:
#		"Down":
#			# Check all corners and see if they're on the bottom side.
#			for corner in $Corners.get_children():
#				if corner.get_child(0).get_child(0).position.y == -POSITION_SCALER:
#					pieces_list.append(corner)
#			# Check all edges and see if they're on the bottom side.
#			for edge in $Edges.get_children():
#				if edge.get_child(0).get_child(0).position.y == -POSITION_SCALER:
#					pieces_list.append(edge)
#			# Check all centers and see if they're on the bottom side.
#			for center in $Centers.get_children():
#				if center.get_child(0).get_child(0).position.y == -POSITION_SCALER:
#					pieces_list.append(center)
#			return pieces_list


# The following lines are code for each individual turn/rotation the cube can make.

# Turn the top face clockwise.
func U():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Update cube logic.
		$CubeLogic.U()
		# Change the currently rotating layer to match the turn being made.
		CURRENTLY_ROTATING_LAYER = "U"
		# Change RADIANS_TO_TURN by -90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns.)
		RADIANS_TO_ROTATE["U"] -= PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
		# Clear all previous pieces from the currently moving parts list.
		CURRENTLY_MOVING_PIECES.clear()
		# Find all the pieces on the top face and add them to the currently moving parts list.
		CURRENTLY_MOVING_PIECES = $CubeLogic.find_pieces_in_layer("U")

# Turn the top face counter clockwise.
func U_CCW():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Update cube logic.
		$CubeLogic.U_CCW()
		# Change the currently rotating layer to match the turn being made.
		CURRENTLY_ROTATING_LAYER = "U"
		# Change RADIANS_TO_TURN by 90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns.)
		RADIANS_TO_ROTATE["U"] += PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
		# Clear all previous pieces from the currently moving parts list.
		CURRENTLY_MOVING_PIECES.clear()
		# Find all the pieces on the top face and add them to the currently moving parts list.
		CURRENTLY_MOVING_PIECES = $CubeLogic.find_pieces_in_layer("U")
	
# Turn the top face 180 degrees.
func U2():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Update cube logic.
		$CubeLogic.U2()
		# Change the currently rotating layer to match the turn being made.
		CURRENTLY_ROTATING_LAYER = "U"
		# Change RADIANS_TO_TURN by 180 degrees.
		RADIANS_TO_ROTATE["U"] += PI
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
		# Clear all previous pieces from the currently moving parts list.
		CURRENTLY_MOVING_PIECES.clear()
		# Find all the pieces on the top face and add them to the currently moving parts list.
		CURRENTLY_MOVING_PIECES = $CubeLogic.find_pieces_in_layer("U")

# Turn the bottom face clockwise.
func D():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Update cube logic.
		$CubeLogic.D()
		# Change the currently rotating layer to match the turn being made.
		CURRENTLY_ROTATING_LAYER = "D"
		# Change RADIANS_TO_TURN by 90 degrees.
		RADIANS_TO_ROTATE["D"] += PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
		# Clear all previous pieces from the currently moving parts list.
		CURRENTLY_MOVING_PIECES.clear()
		# Find all the pieces on the top face and add them to the currently moving parts list.
		CURRENTLY_MOVING_PIECES = $CubeLogic.find_pieces_in_layer("D")

# Turn the bottom face counter clockwise.
func D_CCW():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Update cube logic.
		$CubeLogic.D_CCW()
		# Change the currently rotating layer to match the turn being made.
		CURRENTLY_ROTATING_LAYER = "D"
		# Change RADIANS_TO_TURN by -90 degrees.
		RADIANS_TO_ROTATE["D"] -= PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
		# Clear all previous pieces from the currently moving parts list.
		CURRENTLY_MOVING_PIECES.clear()
		# Find all the pieces on the top face and add them to the currently moving parts list.
		CURRENTLY_MOVING_PIECES = $CubeLogic.find_pieces_in_layer("D")

# Turn the bottom face 180 degrees.
func D2():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Update cube logic.
		$CubeLogic.D2()
		# Change the currently rotating layer to match the turn being made.
		CURRENTLY_ROTATING_LAYER = "D"
		# Change RADIANS_TO_TURN by 180 degrees.
		RADIANS_TO_ROTATE["D"] += PI
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
		# Clear all previous pieces from the currently moving parts list.
		CURRENTLY_MOVING_PIECES.clear()
		# Find all the pieces on the top face and add them to the currently moving parts list.
		CURRENTLY_MOVING_PIECES = $CubeLogic.find_pieces_in_layer("D")

# Turn the front face clockwise.
func F():
	pass
	
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
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Update cube logic.
		$CubeLogic.R()
		# Change the currently rotating layer to match the turn being made.
		CURRENTLY_ROTATING_LAYER = "R"
		# Change RADIANS_TO_TURN by -90 degrees.
		RADIANS_TO_ROTATE["R"] -= PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
		# Clear all previous pieces from the currently moving parts list.
		CURRENTLY_MOVING_PIECES.clear()
		# Find all the pieces on the top face and add them to the currently moving parts list.
		CURRENTLY_MOVING_PIECES = $CubeLogic.find_pieces_in_layer("R")

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
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Update cube logic.
		$CubeLogic.L()
		# Change the currently rotating layer to match the turn being made.
		CURRENTLY_ROTATING_LAYER = "L"
		# Change RADIANS_TO_TURN by 90 degrees.
		RADIANS_TO_ROTATE["L"] += PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
		# Clear all previous pieces from the currently moving parts list.
		CURRENTLY_MOVING_PIECES.clear()
		# Find all the pieces on the top face and add them to the currently moving parts list.
		CURRENTLY_MOVING_PIECES = $CubeLogic.find_pieces_in_layer("L")

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


#func TestingTimer_on_timer_timeout():
	#U()
#	pass


# This function will change the axis that all the moving pieces will be moving around.
func change_axis(axis):
	CURRENT_AXIS_OF_ROTATION = axis
