extends Node3D

var POSITION_SCALER = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This function will return a list of all the pieces on a selected side. It takes the name of the side as an argument. ("Top", "Left", "Front", "Right", "Back", "Down")
func get_pieces_on_side(side):
	# Make a list that will be returned at the end of the function.
	var pieces_list = []
	# Figure out what side is being used.
	match side:
		"Top":
			# Check all corners and see if they're on the top side.
			for corner in $Corners.get_children():
				if corner.position.y == POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the top side.
			for edge in $Edges.get_children():
				if edge.position.y == POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the top side.
			for center in $Centers.get_children():
				if center.position.y == POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list
	# Figure out what side is being used.
	match side:
		"Left":
			# Check all corners and see if they're on the left side.
			for corner in $Corners.get_children():
				if corner.position.x == -POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the left side.
			for edge in $Edges.get_children():
				if edge.position.x == -POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the left side.
			for center in $Centers.get_children():
				if center.position.x == -POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list
	# Figure out what side is being used.
	match side:
		"Front":
			# Check all corners and see if they're on the front side.
			for corner in $Corners.get_children():
				if corner.position.z == POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the front side.
			for edge in $Edges.get_children():
				if edge.position.z == POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the front side.
			for center in $Centers.get_children():
				if center.position.z == POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list
	# Figure out what side is being used.
	match side:
		"Right":
			# Check all corners and see if they're on the right side.
			for corner in $Corners.get_children():
				if corner.position.x == POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the right side.
			for edge in $Edges.get_children():
				if edge.position.x == POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the right side.
			for center in $Centers.get_children():
				if center.position.x == POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list
	# Figure out what side is being used.
	match side:
		"Back":
			# Check all corners and see if they're on the back side.
			for corner in $Corners.get_children():
				if corner.position.z == -POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the back side.
			for edge in $Edges.get_children():
				if edge.position.z == -POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the back side.
			for center in $Centers.get_children():
				if center.position.z == -POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list
	# Figure out what side is being used.
	match side:
		"Down":
			# Check all corners and see if they're on the bottom side.
			for corner in $Corners.get_children():
				if corner.position.y == -POSITION_SCALER:
					pieces_list.append(corner)
			# Check all edges and see if they're on the bottom side.
			for edge in $Edges.get_children():
				if edge.position.y == -POSITION_SCALER:
					pieces_list.append(edge)
			# Check all centers and see if they're on the bottom side.
			for center in $Centers.get_children():
				if center.position.y == -POSITION_SCALER:
					pieces_list.append(center)
			return pieces_list


# The following lines are code for each individual turn/rotation the cube can make.

# Turn the top face clockwise.
func U():
	# Update cube logic.
	$CubeLogic.U()
	# Physically turn the cube.
	

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
	# Update cube logic.
	$CubeLogic.F()

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
