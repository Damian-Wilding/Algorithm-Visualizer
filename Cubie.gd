extends MeshInstance3D

# This variable keeps track of what sides the cubie is currently on. (Edges will have 2 sides, corners will have 3, centers will have one, and the core will have 0.)
@export var ON_SIDES = ""
# These 3 variables keep track of how far along the piece is along the X, Y, and Z rotation paths. (Values will range from 0 to 1.)
@export var X_ROTATION_PROGRESS = 0.0
@export var Y_ROTATION_PROGRESS = 0.0
@export var Z_ROTATION_PROGRESS = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# This function sets the sides of an edge piece.
func edge_set_sides(side1, side2):
	# If the values of side1 and side2 are both "", then change the sides to not be anything. (This basically removes all side assignments for an edge. Not sure if this will ever be done, but better safe than sorry.)
	if side1 == "" and side2 == "":
		ON_SIDES = ""
	# If the side1 value is "" and the side value is an actual character, then leave the first side value the way it is and change the side2 value to equal the value given.
	elif side1 == "" and side2 != "":
		ON_SIDES[1] = side2
	# If the side1 value is a character and the side2 value is "", then leave the second side value the way it is and change the side1 value to equal the value given.
	elif side1 != "" and side2 == "":
		ON_SIDES[0] = side1
	# If a character is provided for both sides, then set both sides to equal that character.
	elif side1 != "" and side2 != "":
		ON_SIDES[0] = side1
		ON_SIDES[1] = side2
	# If none of the 4 above cases occur, then theres an error.
	else:
		print("Cubie.edge_set_sides error: Something was entered wrong.")
		ON_SIDES[0] = ""
		ON_SIDES[1] = ""
		
		
# This function will set the sides of a corner piece.
func corner_set_sides(side1, side2, side3):
	# If all 3 values supplied are "", then remove all side assignments for the corner. (This will probably never be used, but I put it here just in case.)
	if side1 == "" and side2 == "" and side3 == "":
		ON_SIDES[0] = ""
		ON_SIDES[1] = ""
		ON_SIDES[2] = ""
	# If side1 isn't "", then assign the value given to the first side.
	if side1 != "":
		ON_SIDES[0] = side1
	# If side2 isn't "", then assign the value given to the second side.
	if side2 == "":
		ON_SIDES[1] = side2
	# If side3 isn't "", then assign the value given to the third side.
	if side3 != "":
		ON_SIDES[2] = side3
	# I believe that covers all cases so this should be fine.
	
	
