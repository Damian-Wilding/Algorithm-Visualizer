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
var IS_A_TURN_HAPPENING_OR_IS_IT_THE_FIRST_FRAME_AFTER_A_TURN_HAS_FINISHED: bool = true
# This bool will keep track of whether the cube is going to be moving or not. If it is false, the cube will be frozen until it turns to true.
var IS_CUBE_ACTIVE: bool = true
# This dictionary contains all of the pieces in the puzzle and their home position/rotations. It will be used to reset all the pieces when the cube needs to be reset/instantly solved.
var HOME_POSITIONS_AND_ROTATIONS = {"ItalianCorner": [Vector3(3,3,3), Vector3(0,-PI/2,-PI/2)], "IrishCorner": [Vector3(-3,3,3), Vector3(0,-PI/2,0)], "USACorner": [Vector3(3,3,-3), Vector3(-PI/2,-PI/2,0)], "NetherlandsCorner": [Vector3(-3,3,-3), Vector3(0,-PI/2,PI/2)], "BobMarleyCorner": [Vector3(3,-3,3), Vector3(-PI,PI/2,PI)], "SpriteCorner": [Vector3(-3,-3,3), Vector3(PI,PI/2,PI)], "PrimaryCorner": [Vector3(3,-3,-3), Vector3(PI,PI/2,PI)], "NerfCorner": [Vector3(-3,-3,-3), Vector3(0,-PI/2,0)], "WG": [Vector3(0,3,3), Vector3(0,-PI/2,0)], "WB": [Vector3(0,3,-3), Vector3(0,-PI/2,0)], "WR": [Vector3(3,3,0), Vector3(0,-PI/2,0)], "WO": [Vector3(-3,3,0), Vector3(0,-PI/2,0)], "GR": [Vector3(3,0,3), Vector3(0,-PI/2,0)], "BR": [Vector3(3,0,-3), Vector3(0,-PI/2,0)], "GO": [Vector3(-3,0,3), Vector3(0,-PI/2,0)], "BO": [Vector3(-3,0,-3), Vector3(0,-PI/2,0)], "YG": [Vector3(0,-3,3), Vector3(0,-PI/2,0)], "YB": [Vector3(0,-3,-3), Vector3(0,-PI/2,0)], "YR": [Vector3(3,-3,0), Vector3(0,-PI/2,0)], "YO": [Vector3(-3,-3,0), Vector3(0,-PI/2,0)], "WhiteCenter": [Vector3(0,3,0), Vector3(0,0,0)], "YellowCenter": [Vector3(0,-3,0), Vector3(-PI,0,PI)], "GreenCenter": [Vector3(0,0,3), Vector3(PI/2,-PI/2,0)], "BlueCenter": [Vector3(0,0,-3), Vector3(-PI/2,-PI/2,0)], "RedCenter": [Vector3(3,0,0), Vector3(0,-PI/2,-PI/2)], "OrangeCenter": [Vector3(-3,0,0), Vector3(0,-PI/2,PI/2)], "Core": [Vector3(0,0,0), Vector3(0,0,0)]}


# Called when the node enters the scene tree for the first time.
func _ready():
	# Make a list with every piece of the cube in it. (This is used for debugging and cube rotations.)
	# First add all the pieces to the list.
	for piece in get_children():
		if piece.is_in_group("Pieces"):
			ALL_PIECES_LIST.append(piece)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Have the cube rotate if the timer is running and the IS_CUBE_ACTIVE bool is true. (and by running, I mean less than the time allowed for each turn.)
	if ELAPSED_TIME < TIME_TO_TURN and IS_CUBE_ACTIVE == true:
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
	elif IS_A_TURN_HAPPENING_OR_IS_IT_THE_FIRST_FRAME_AFTER_A_TURN_HAS_FINISHED == true:
		# This elif statement will only be entered if it is currently the first frame after a turn has finished.
		# Fix any desyncs with the pieces positions or rotations
		fix_desyncs()
		# Now change the IS_A_TURN_HAPPENING_OR_IS_IT_THE_FIRST_FRAME_AFTER_A_TURN_HAS_FINISHED variable to be false so this elif statement will not be entered again next frame.
		IS_A_TURN_HAPPENING_OR_IS_IT_THE_FIRST_FRAME_AFTER_A_TURN_HAS_FINISHED = false


# This function is used to make any turn/rotation. It simplifies the clutter in each turn/rotation function and saves code.
func Turn(radians_to_rotate, axis_of_rotation, layer, turn_name):
	# Only start the turn if the cube isn't currently turning.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Set the radians to rotate based off the arguement given.
		RADIANS_TO_ROTATE = radians_to_rotate
		# Update the axis that the pieces will be orbiting around based off the arguement given.
		change_axis(axis_of_rotation)
		# Remove all previous pieces as children of the turning layer.
		reset_turning_layer()
		# Now find all the pieces in the layer provided and make their parent the turning layer.
		for piece in $CubeLogic.find_pieces_in_layer(layer):
			remove_child(piece)
			$TurningSide.add_child(piece)
		# Change IS_A_TURN_HAPPENING_OR_IS_IT_THE_FIRST_FRAME_AFTER_A_TURN_HAS_FINISHED to be true since a turn is now underway.
		IS_A_TURN_HAPPENING_OR_IS_IT_THE_FIRST_FRAME_AFTER_A_TURN_HAS_FINISHED = true
		# Update cube logic.
		$CubeLogic.call(turn_name)						# I may change this function at a later date and just find pieces based on their global position, but if this line works, then I'll just keep it.
		# Change the ELAPSED_TIME to be 0 since it is restarting for a new turn. (This makes it so that another turn won't start while this turn is still going.)
		ELAPSED_TIME = 0.0


# The following lines are code for each individual turn/rotation the cube can make. They will all use the above Turn() function.
	
# Turn the top face clockwise.
func U():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI/2, "Y", "U", "U")

# Turn the top face counter clockwise.
func U_CCW():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI/2, "Y", "U", "U_CCW")
	
# Turn the top face 180 degrees.
func U2():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI, "Y", "U", "U2")
	
# Turn the bottom face clockwise.
func D():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI/2, "Y", "D", "D")
	
# Turn the bottom face counter clockwise.
func D_CCW():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI/2, "Y", "D", "D_CCW")
	
# Turn the bottom face 180 degrees.
func D2():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI, "Y", "D", "D2")
	
# Turn the front face clockwise.
func F():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI/2, "Z", "F", "F")
	
# Turn the front face counter clockwise.
func F_CCW():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI/2, "Z", "F", "F_CCW")

# Turn the front face 180 degrees.
func F2():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI, "Z", "F", "F2")

# Turn the back face clockwise.
func B():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI/2, "Z", "B", "B")

# Turn the back face counter clockwise.
func B_CCW():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI/2, "Z", "B", "B_CCW")

# Turn the back face 180 degrees.
func B2():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI, "Z", "B", "B2")

# Turn the right face clockwise.
func R():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI/2, "X", "R", "R")

# Turn the right face counter clockwise.
func R_CCW():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI/2, "X", "R", "R_CCW")

# Turn the right face 180 degrees.
func R2():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI, "X", "R", "R2")

# Turn the left face clockwise.
func L():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI/2, "X", "L", "L")

# Turn the left face counter clockwise.
func L_CCW():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI/2, "X", "L", "L_CCW")

# Turn the left face 180 degrees.
func L2():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI, "X", "L", "L2")

# Rotate the entire cube clockwise along the x axis.
func X():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI/2, "X", "ALL", "X")
	
# Rotate the entire cube counter clockwise along the X axis.
func X_CCW():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI/2, "X", "ALL", "X_CCW")
	
# Rotate the entire cube 180 degrees along the x axis.
func X2():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI, "X", "ALL", "X2")
	
# Rotate the entire cube clockwise along the y axis.
func Y():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI/2, "Y", "ALL", "Y")
	
# Rotate the entire cube counter clockwise along the y axis.
func Y_CCW():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI/2, "Y", "ALL", "Y_CCW")
	
# Rotate the entire cube 180 degrees along the y axis.
func Y2():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI, "Y", "ALL", "Y2")
	
# Rotate the entire cube clockwise along the z axis.
func Z():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI/2, "Z", "ALL", "Z")
	
# Rotate the entire cube counter clockwise along the z axis.
func Z_CCW():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI/2, "Z", "ALL", "Z_CCW")
	
# Rotate the entire cube 180 degrees along the z axis.
func Z2():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(-PI, "Z", "ALL", "Z2")
	
# Turn the d layers clockwise.
func d():
	# Use the turn() function to make the turn by giving it the correct arguements.
	Turn(PI/2, "Y", "d", "d")
	
# This function will pretend to do a turn but nothing will actually move for the duration of the "turn". This will be used to pause the cube's movement for however long you tell it to.
func Nothing(amount_of_seconds_to_do_nothing):
	# Only do this if the cube isn't currently turning already.
	if ELAPSED_TIME >= TIME_TO_TURN:
		# Remove all previous pieces from the currently turning layer(s).
		reset_turning_layer()
		# Change IS_A_TURN_HAPPENING_OR_IS_IT_THE_FIRST_FRAME_AFTER_A_TURN_HAS_FINISHED to be true since a turn is now underway.
		IS_A_TURN_HAPPENING_OR_IS_IT_THE_FIRST_FRAME_AFTER_A_TURN_HAS_FINISHED = true
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
		
		
# This function resets the cube's piece's positions and rotations to make the cube solved again.
func reset():
	# First, reset the cube logic so that it reflects a solved cube.
	$CubeLogic.reset_all_stickers()
	# Remove all children from turning side and re add them as children to cube/this node.
	for piece in $TurningSide.get_children():
		$TurningSide.remove_child(piece)
		add_child(piece)
	# Now go through the HOME_POSITIONS_AND_ROTATIONS and set each pieces position and rotation to be what they are in the list. 
	for part in HOME_POSITIONS_AND_ROTATIONS:
		get_node(part).position = HOME_POSITIONS_AND_ROTATIONS[part][0]
		get_node(part).rotation = HOME_POSITIONS_AND_ROTATIONS[part][1]
