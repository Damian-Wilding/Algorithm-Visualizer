extends Node3D

# This variable represents how many radians the current rotation is. (Positive is counter clockwise and negative is counter clockwise.)
var RADIANS_TO_ROTATE = 0
# This variable will tell the process function how much each moving piece needs to be rotated for the current turn being made since the last frame.
var AMOUNT_TO_TURN = 0
# This controls how long the cube turns take/ how long the cube can't be turned for while a turn is being made. (Time in seconds.)
var TIME_TO_TURN = 0.50
# This number keeps track of how much time has passed since the current turn started. (It starts off at 10 so you can make turns immediately.)
var ELAPSED_TIME = 10.0
# This list is going to contain all of the pieces of the cube. (It's empty here, but the pieces will be added in _ready().)
var ALL_PIECES_LIST = []
# This variable will tell the cube which axis to rotate on. ( U() would be "Y", D() would be "-Y", F() would be "Z", B() would be "-Z", etc...)
var CURRENT_AXIS_OF_ROTATION = "Y"
# This bool is going to keep track of whether it is the first frame that occurs after a turn has finished. It will remain true while a turn is being made and used to enter an elif statement in process(). After that elif statement is finished, it will turn to false. Once a new turn starts, it will turn to true again.
var is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	# Make a list with every piece of the cube in it. (This is used for debugging and cube rotations.)
	# First add all the pieces to the list.
	for piece in get_tree().get_nodes_in_group("Pieces"):
		ALL_PIECES_LIST.append(piece)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if Input.is_action_just_released("ui_accept") and ELAPSED_TIME >= TIME_TO_TURN:
		U()
	
				
	elif Input.is_action_just_released("ui_text_caret_down") and ELAPSED_TIME >= TIME_TO_TURN:
		Nothing(5)
		
	
	# Have the cube rotate if the timer is running (and by running, I mean less than the time allowed for each turn.
	if ELAPSED_TIME < TIME_TO_TURN:
	#	# Add the time that has passed since the last frame to the ELAPSED_TIME variable.
		ELAPSED_TIME += delta
		# Calculate how much progress should be made based on long it's been since the last frame (the delta).
		AMOUNT_TO_TURN = delta * RADIANS_TO_ROTATE * (1 / TIME_TO_TURN)			# The (1/ TIME_TO_TURN just converts the time to turn to be the multiplier needed to make the turn finish aproximately right as time runs out)
		# Rotate the pieces based on the axis rotational velocities. 
		if CURRENT_AXIS_OF_ROTATION == "Y":
			$TurningSide.rotation.y += AMOUNT_TO_TURN
		elif CURRENT_AXIS_OF_ROTATION == "X":
			$TurningSide.rotation.x += AMOUNT_TO_TURN
		elif CURRENT_AXIS_OF_ROTATION == "Z":
			$TurningSide.rotation.z += AMOUNT_TO_TURN
	elif is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished == true:
		# This elif statement will only be entered if it is currently the first frame after a turn has finished.
		# Fix any desyncs with the pieces positions or rotations
		fix_desyncs()
		# Now change the is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished variable to be false so this elif statement will not be entered again next frame.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = false


# The following lines are code for each individual turn/rotation the cube can make.

# Turn the top face clockwise.
func U():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("U"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.U()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the top face counter clockwise.
func U_CCW():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("U"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.U_CCW()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Turn the top face 180 degrees.
func U2():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -180 degrees. (For some reason counterclockwise turns are considered + degree turns and clockwise turns are - degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("U"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.U2()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Turn the bottom face clockwise.
func D():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 90 degrees. 
		RADIANS_TO_ROTATE = PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("D"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.D()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Turn the bottom face counter clockwise.
func D_CCW():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -90 degrees. 
		RADIANS_TO_ROTATE = -PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("D"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.D_CCW()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Turn the bottom face 180 degrees.
func D2():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 180 degrees. 
		RADIANS_TO_ROTATE = PI
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("D"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.D2()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Turn the front face clockwise.
func F():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Z")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("F"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.F()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Turn the front face counter clockwise.
func F_CCW():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Z")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("F"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.F_CCW()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the front face 180 degrees.
func F2():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -180 degrees. (For some reason counterclockwise turns are considered + degree turns and clockwise turns are - degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI
		# Update the axis that the pieces will be turning around.
		change_axis("Z")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("F"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.F2()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the back face clockwise.
func B():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 90 degrees. 
		RADIANS_TO_ROTATE = PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Z")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("B"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.B()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the back face counter clockwise.
func B_CCW():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -90 degrees. 
		RADIANS_TO_ROTATE = -PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Z")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("B"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.B_CCW()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the back face 180 degrees.
func B2():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 180 degrees. 
		RADIANS_TO_ROTATE = PI
		# Update the axis that the pieces will be turning around.
		change_axis("Z")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("B"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.B2()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the right face clockwise.
func R():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("R"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.R()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the right face counter clockwise.
func R_CCW():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("R"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.R_CCW()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the right face 180 degrees.
func R2():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -180 degrees. (For some reason counterclockwise turns are considered + degree turns and clockwise turns are - degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("R"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.R2()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the left face clockwise.
func L():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 90 degrees.
		RADIANS_TO_ROTATE = PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("L"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.L()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the left face counter clockwise.
func L_CCW():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -90 degrees.
		RADIANS_TO_ROTATE = -PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("L"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.L_CCW()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Turn the left face 180 degrees.
func L2():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 180 degrees.
		RADIANS_TO_ROTATE = PI
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Find all the pieces in the top layer and add them to the turning side node.
		for piece in $CubeLogic.find_pieces_in_layer("L"):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.L2()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# Rotate the entire cube clockwise along the x axis.
func X():
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Cube rotations (where you rotate the cube to face another side without turning any pieces) move all pieces so add every piece to the turning side node.
		for piece in ALL_PIECES_LIST:
			remove_child(piece)
			$TurningSide.add_child(piece)	
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.X()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Rotate the entire cube counter clockwise along the X axis.
func X_CCW():
	# Update cube logic.
	$CubeLogic.X_CCW()
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Cube rotations (where you rotate the cube to face another side without turning any pieces) move all pieces so add every piece to the turning side node.
		for piece in ALL_PIECES_LIST:
			remove_child(piece)
			$TurningSide.add_child(piece)	
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.X_CCW()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Rotate the entire cube 180 degrees along the x axis.
func X2():
	# Update cube logic.
	$CubeLogic.X2()
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -180 degrees. (For some reason counterclockwise turns are considered + degree turns and clockwise turns are - degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI
		# Update the axis that the pieces will be turning around.
		change_axis("X")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Cube rotations (where you rotate the cube to face another side without turning any pieces) move all pieces so add every piece to the turning side node.
		for piece in ALL_PIECES_LIST:
			remove_child(piece)
			$TurningSide.add_child(piece)	
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.X2()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Rotate the entire cube clockwise along the y axis.
func Y():
	# Update cube logic.
	$CubeLogic.Y()
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Cube rotations (where you rotate the cube to face another side without turning any pieces) move all pieces so add every piece to the turning side node.
		for piece in ALL_PIECES_LIST:
			remove_child(piece)
			$TurningSide.add_child(piece)	
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.Y()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Rotate the entire cube counter clockwise along the y axis.
func Y_CCW():
	# Update cube logic.
	$CubeLogic.Y_CCW()
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Cube rotations (where you rotate the cube to face another side without turning any pieces) move all pieces so add every piece to the turning side node.
		for piece in ALL_PIECES_LIST:
			remove_child(piece)
			$TurningSide.add_child(piece)	
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.Y_CCW()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Rotate the entire cube 180 degrees along the y axis.
func Y2():
	# Update cube logic.
	$CubeLogic.Y2()
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -180 degrees. (For some reason counterclockwise turns are considered + degree turns and clockwise turns are - degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI
		# Update the axis that the pieces will be turning around.
		change_axis("Y")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Cube rotations (where you rotate the cube to face another side without turning any pieces) move all pieces so add every piece to the turning side node.
		for piece in ALL_PIECES_LIST:
			remove_child(piece)
			$TurningSide.add_child(piece)	
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.Y2()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Rotate the entire cube clockwise along the z axis.
func Z():
	# Update cube logic.
	$CubeLogic.Z()
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Z")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Cube rotations (where you rotate the cube to face another side without turning any pieces) move all pieces so add every piece to the turning side node.
		for piece in ALL_PIECES_LIST:
			remove_child(piece)
			$TurningSide.add_child(piece)	
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.Z()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Rotate the entire cube counter clockwise along the z axis.
func Z_CCW():
	# Update cube logic.
	$CubeLogic.Z_CCW()
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to 90 degrees. (For some reason counterclockwise turns are considered +90 degree turns and clockwise turns are -90 degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = PI / 2
		# Update the axis that the pieces will be turning around.
		change_axis("Z")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Cube rotations (where you rotate the cube to face another side without turning any pieces) move all pieces so add every piece to the turning side node.
		for piece in ALL_PIECES_LIST:
			remove_child(piece)
			$TurningSide.add_child(piece)	
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.Z_CCW()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0
	
# Rotate the entire cube 180 degrees along the z axis.
func Z2():
	# Update cube logic.
	$CubeLogic.Z2()
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Change RADIANS_TO_ROTATE to -180 degrees. (For some reason counterclockwise turns are considered + degree turns and clockwise turns are - degree turns. At least on the front, right, and top layers/faces.)
		RADIANS_TO_ROTATE = -PI
		# Update the axis that the pieces will be turning around.
		change_axis("Z")
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Cube rotations (where you rotate the cube to face another side without turning any pieces) move all pieces so add every piece to the turning side node.
		for piece in ALL_PIECES_LIST:
			remove_child(piece)
			$TurningSide.add_child(piece)	
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Update cube logic.
		$CubeLogic.Z2()  					# This line probably won't be used anymore since I'm now planning on finding pieces by their global positions if cube logic doesn't work for some reason.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0

# This function will pretend to do a turn but nothing will actually move for the duration of the "turn". This will be used to pause the cube's movement for however long you tell it to.
func Nothing(amount_of_seconds_to_do_nothing):
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Change is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished to be true since a turn is now underway.
		is_a_turn_happening_or_is_it_the_first_frame_after_a_turn_has_finished = true
		# Change the ELAPSED_TIME to be the time allowed for a normal turn minus the amount of time that we want the cube to not do anything for. (This makes it so that another turn won't start while this "turn" is still going.)
		ELAPSED_TIME = TIME_TO_TURN - amount_of_seconds_to_do_nothing


# This function will change the axis that all the moving pieces will be moving around.
func change_axis(axis):
	CURRENT_AXIS_OF_ROTATION = axis
		

# This function will reset the currently turning side. (Removes and updates all child pieces.)
func reset_turning_layer():
	# First iterate through the pieces in the layer.
	for piece in $TurningSide.get_children():
		# Temporarily store the piece's global position and rotation. (They will reset to (0, 0, 0) and (0, 0, 0) when they are removed from their parent (I think.), so we have to manually set them after we readd them as children to the Cube Node.)
		var temporary_position = piece.global_position
		var temporary_rotation = piece.global_rotation
		# Now remove the piece from the turning side node and readd them as children to the cube node.
		$TurningSide.remove_child(piece)
		add_child(piece)
		# Now reset the pieces position and rotation. I'll need to check this step later and make sure it's not redundant.
		piece.global_position = temporary_position
		piece.global_rotation = temporary_rotation
	# All the pieces have been removed from the turning side node and have been taken care of. Now reset the rotation of the turning side node since we want it to start from (0, 0, 0) every turn.
	$TurningSide.rotation = Vector3(0, 0, 0)
	

# This function will fix the small desyncs that happen after every turn. These desyncs occur because every frame takes a different amount of time to generate. (This may push the cube to an incorrect position if your PC is really slow or if you have the turn speed way too high. I'm not sure how likely this is to happen in all actuality, but it put this disclaimer here just to be safe.)
func fix_desyncs():
	# Figure out which axis the last rotation/turn was on.
	if CURRENT_AXIS_OF_ROTATION == "X":
		# It was on the X axis. Snap the rotation of the turning layer to the nearest multiple of 90 degrees on the X axis.
		$TurningSide.rotation.x = deg_to_rad(snappedf(rad_to_deg($TurningSide.rotation.x), 90.00))		# Using the deg_to_rad and rad_to_deg insures that no matter how many turns you do, the cube will never get a noticeable desync. (This honestly will probably never make a difference, but I saw a youtube video covering this issue in a video game I've played before so I felt like adding it anyways.)
	elif CURRENT_AXIS_OF_ROTATION == "Y":
		# It was on the Y axis. Snap the rotation of the turning layer to the nearest multiple of 90 degrees on the Y axis.
		$TurningSide.rotation.y = deg_to_rad(snappedf(rad_to_deg($TurningSide.rotation.y), 90.00))
	elif CURRENT_AXIS_OF_ROTATION == "Z":
		# It was on the Z axis. Snap the rotation of the turning layer to the nearest multiple of 90 degrees on the Z axis.
		$TurningSide.rotation.z = deg_to_rad(snappedf(rad_to_deg($TurningSide.rotation.z), 90.00))
