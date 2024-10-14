extends Node3D

# This dictionary keeps track of every sticker's color. (Capital letter means corner sticker, lowercase letter means edge sticker, and 2 capital letters represent center stickers. This follows the Spef's lettering scheme used in blindfolded Rubik's cube solving.)
var STICKER_VALUES = {"A":"", "B":"", "C":"", "D":"", "E":"", "F":"", "G":"", "H":"", "I":"", "J":"", "K":"", "L":"", "M":"", "N":"", "O":"", "P":"", "Q":"", "R":"", "S":"", "T":"", "U":"", "V":"", "W":"", "X":"", "a":"", "b":"", "c":"", "d":"", "e":"", "f":"", "g":"", "h":"", "i":"", "j":"", "k":"", "l":"", "m":"", "n":"", "o":"", "p":"", "q":"", "r":"", "s":"", "t":"", "u":"", "v":"", "w":"", "x":"", "UC":"","LC":"", "FC":"", "RC":"", "BC":"", "DC":""}
# This dictionary is the exact same, but it will be the values of the stickers after the previous turn has been made. (It's used to find the new color to set a sticker to.)
var PREVIOUS_STICKER_VALUES = {"A":"", "B":"", "C":"", "D":"", "E":"", "F":"", "G":"", "H":"", "I":"", "J":"", "K":"", "L":"", "M":"", "N":"", "O":"", "P":"", "Q":"", "R":"", "S":"", "T":"", "U":"", "V":"", "W":"", "X":"", "a":"", "b":"", "c":"", "d":"", "e":"", "f":"", "g":"", "h":"", "i":"", "j":"", "k":"", "l":"", "m":"", "n":"", "o":"", "p":"", "q":"", "r":"", "s":"", "t":"", "u":"", "v":"", "w":"", "x":"", "UC":"","LC":"", "FC":"", "RC":"", "BC":"", "DC":""}
# This list just holds all the individual location names in it. There are 6 lists in this list (one for each side) that contain 4 corner locations, 4 edge locations, and 1 center location. (The locations are keys in the sticker_values dictionary.) (each of the 6 lists starts with the 4 corner values together in a list, then the edge values together in a list, and last, the center value that's not in a list.) (ex: [[corner1, corner2, corner3, corner4], [edge1, edge2, edge3, edge4], center] )
var LOCATION_LIST = [[["A", "B", "C", "D"], ["a", "b", "c", "d"], "UC"], [["E", "F", "G", "H"], ["e", "f", "g", "h"], "LC"], [["I", "J", "K", "L"], ["i", "j", "k", "l"], "FC"], [["M", "N", "O", "P"], ["m", "n", "o", "p"], "RC"], [["Q", "R", "S", "T"], ["q", "r", "s", "t"], "BC"], [["U", "V", "W", "X"], ["u", "v", "w", "x"], "DC"]]
# The following 4 variables are shortcuts to the edges, corners, centers, and core child nodes of the cube. They are siblings to this node (cube logic).
var edges
var corners
var centers
var core

# Called when the node enters the scene tree for the first time.
func _ready():
	# Assign the right colors to all of the stickers. (Always starts with the white side on top and the green side in the front.)
	# White side stickers.
	set_sides_colors("U", "W", "W", "W", "W", "W", "W", "W", "W", "W")
	# Yellow side stickers.						
	set_sides_colors("D", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y")
	# Green side stickers.						
	set_sides_colors("F", "G", "G", "G", "G", "G", "G", "G", "G", "G")
	# Blue side stickers.						
	set_sides_colors("B", "B", "B", "B", "B", "B", "B", "B", "B", "B")	
	# Red side stickers.						
	set_sides_colors("R", "R", "R", "R", "R", "R", "R", "R", "R", "R")
	# Orange side stickers.						
	set_sides_colors("L", "O", "O", "O", "O", "O", "O", "O", "O", "O")
	
	# This is a shortened name for the $Edges node that is a sibling node to this node (cube logic).
	edges = get_parent().get_node("Edges")
	# This is a shortened name for the $Corners node that is a sibling node to this node (cube logic).
	corners = get_parent().get_node("Corners")
	# This is a shortened name for the $Center node that is a sibling node to this node (cube logic).
	centers = get_parent().get_node("Centers")
	# This is a shortened name for the $Core node that is a sibling node to this node (cube logic).
	core = get_parent().get_node("Core")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
# Set all the sticker's colors on any given side. The first argument is the side, and the rest are the desired colors for each sticker.
func set_sides_colors(side, center, corner1, corner2, corner3, corner4, edge1, edge2, edge3, edge4):
	match side:
		"U":
			STICKER_VALUES.UC = center
			STICKER_VALUES.A = corner1
			STICKER_VALUES.B = corner2
			STICKER_VALUES.C = corner3
			STICKER_VALUES.D = corner4
			STICKER_VALUES.a = edge1
			STICKER_VALUES.b = edge2
			STICKER_VALUES.c = edge3
			STICKER_VALUES.d = edge4
		"L":
			STICKER_VALUES.LC = center
			STICKER_VALUES.E = corner1
			STICKER_VALUES.F = corner2
			STICKER_VALUES.G = corner3
			STICKER_VALUES.H = corner4
			STICKER_VALUES.e = edge1
			STICKER_VALUES.f = edge2
			STICKER_VALUES.g = edge3
			STICKER_VALUES.h = edge4
		"F":
			STICKER_VALUES.FC = center
			STICKER_VALUES.I = corner1
			STICKER_VALUES.J = corner2
			STICKER_VALUES.K = corner3
			STICKER_VALUES.L = corner4
			STICKER_VALUES.i = edge1
			STICKER_VALUES.j = edge2
			STICKER_VALUES.k = edge3
			STICKER_VALUES.l = edge4
		"R":
			STICKER_VALUES.RC = center
			STICKER_VALUES.M = corner1
			STICKER_VALUES.N = corner2
			STICKER_VALUES.O = corner3
			STICKER_VALUES.P = corner4
			STICKER_VALUES.m = edge1
			STICKER_VALUES.n = edge2
			STICKER_VALUES.o = edge3
			STICKER_VALUES.p = edge4
		"B":
			STICKER_VALUES.BC = center
			STICKER_VALUES.Q = corner1
			STICKER_VALUES.R = corner2
			STICKER_VALUES.S = corner3
			STICKER_VALUES.T = corner4
			STICKER_VALUES.q = edge1
			STICKER_VALUES.r = edge2
			STICKER_VALUES.s = edge3
			STICKER_VALUES.t = edge4
		"D":
			STICKER_VALUES.DC = center
			STICKER_VALUES.U = corner1
			STICKER_VALUES.V = corner2
			STICKER_VALUES.W = corner3
			STICKER_VALUES.X = corner4
			STICKER_VALUES.u = edge1
			STICKER_VALUES.v = edge2
			STICKER_VALUES.w = edge3
			STICKER_VALUES.x = edge4
		_:
			print("Something went wrong.")
			

# This function will take a dictionary and use it to update sticker values. The keys are the stickers that need to be changed and their values are the colors that are going to be changed to.
func change_selected_stickers(sticker_dictionary):
	# For each key in sticker_dictionary...
	for sticker in sticker_dictionary:
		# Change the key's value in STICKER_VALUES too equal the value we get when we use the value of the key in the sticker_dictionary and place that into PREVIOUS_STICKER_VALUES as a key.
		STICKER_VALUES[sticker] = PREVIOUS_STICKER_VALUES[sticker_dictionary[sticker]]
		# I'm sort of struggling to think about all the layers in this line above, but I believe it is correct. If something isn't working in cube logic, I'd start by making this more lines so it's easier to understand. That will make it easier to know if there is a mistake here or not.


# This function takes the current value of every sticker on the provided side and sets the previous color of the sticker to be equal to that value.
func update_all_stickers_previous_values_on_side(side):
	match side:
		"U":
			PREVIOUS_STICKER_VALUES.UC = STICKER_VALUES.UC
			PREVIOUS_STICKER_VALUES.A = STICKER_VALUES.A
			PREVIOUS_STICKER_VALUES.B = STICKER_VALUES.B
			PREVIOUS_STICKER_VALUES.C = STICKER_VALUES.C
			PREVIOUS_STICKER_VALUES.D = STICKER_VALUES.D
			PREVIOUS_STICKER_VALUES.a = STICKER_VALUES.a
			PREVIOUS_STICKER_VALUES.b = STICKER_VALUES.b
			PREVIOUS_STICKER_VALUES.c = STICKER_VALUES.c
			PREVIOUS_STICKER_VALUES.d = STICKER_VALUES.d
		"L":
			PREVIOUS_STICKER_VALUES.LC = STICKER_VALUES.LC
			PREVIOUS_STICKER_VALUES.E = STICKER_VALUES.E
			PREVIOUS_STICKER_VALUES.F = STICKER_VALUES.F
			PREVIOUS_STICKER_VALUES.G = STICKER_VALUES.G
			PREVIOUS_STICKER_VALUES.H = STICKER_VALUES.H
			PREVIOUS_STICKER_VALUES.e = STICKER_VALUES.e
			PREVIOUS_STICKER_VALUES.f = STICKER_VALUES.f
			PREVIOUS_STICKER_VALUES.g = STICKER_VALUES.g
			PREVIOUS_STICKER_VALUES.h = STICKER_VALUES.h
		"F":
			PREVIOUS_STICKER_VALUES.FC = STICKER_VALUES.FC
			PREVIOUS_STICKER_VALUES.I = STICKER_VALUES.I
			PREVIOUS_STICKER_VALUES.J = STICKER_VALUES.J
			PREVIOUS_STICKER_VALUES.K = STICKER_VALUES.K
			PREVIOUS_STICKER_VALUES.L = STICKER_VALUES.L
			PREVIOUS_STICKER_VALUES.i = STICKER_VALUES.i
			PREVIOUS_STICKER_VALUES.j = STICKER_VALUES.j
			PREVIOUS_STICKER_VALUES.k = STICKER_VALUES.k
			PREVIOUS_STICKER_VALUES.l = STICKER_VALUES.l
		"R":
			PREVIOUS_STICKER_VALUES.RC = STICKER_VALUES.RC
			PREVIOUS_STICKER_VALUES.M = STICKER_VALUES.M
			PREVIOUS_STICKER_VALUES.N = STICKER_VALUES.N
			PREVIOUS_STICKER_VALUES.O = STICKER_VALUES.O
			PREVIOUS_STICKER_VALUES.P = STICKER_VALUES.P
			PREVIOUS_STICKER_VALUES.m = STICKER_VALUES.m
			PREVIOUS_STICKER_VALUES.n = STICKER_VALUES.n
			PREVIOUS_STICKER_VALUES.o = STICKER_VALUES.o
			PREVIOUS_STICKER_VALUES.p = STICKER_VALUES.p
		"B":
			PREVIOUS_STICKER_VALUES.BC = STICKER_VALUES.BC
			PREVIOUS_STICKER_VALUES.Q = STICKER_VALUES.Q
			PREVIOUS_STICKER_VALUES.R = STICKER_VALUES.R
			PREVIOUS_STICKER_VALUES.S = STICKER_VALUES.S
			PREVIOUS_STICKER_VALUES.T = STICKER_VALUES.T
			PREVIOUS_STICKER_VALUES.q = STICKER_VALUES.q
			PREVIOUS_STICKER_VALUES.r = STICKER_VALUES.r
			PREVIOUS_STICKER_VALUES.s = STICKER_VALUES.s
			PREVIOUS_STICKER_VALUES.t = STICKER_VALUES.t
		"D":
			PREVIOUS_STICKER_VALUES.DC = STICKER_VALUES.DC
			PREVIOUS_STICKER_VALUES.U = STICKER_VALUES.U
			PREVIOUS_STICKER_VALUES.V = STICKER_VALUES.V
			PREVIOUS_STICKER_VALUES.W = STICKER_VALUES.W
			PREVIOUS_STICKER_VALUES.X = STICKER_VALUES.X
			PREVIOUS_STICKER_VALUES.u = STICKER_VALUES.u
			PREVIOUS_STICKER_VALUES.v = STICKER_VALUES.v
			PREVIOUS_STICKER_VALUES.w = STICKER_VALUES.w
			PREVIOUS_STICKER_VALUES.x = STICKER_VALUES.x
		_:
			print("Something went wrong.")
	
		
# This function updates all the stickers on every side by applying update_all_stickers_previous_values_on_side() to each of the 6 sides.
func update_all_stickers():
	# call update_all_stickers_previous_values_on_side on each of the 6 sides.
	update_all_stickers_previous_values_on_side("U")
	update_all_stickers_previous_values_on_side("L")
	update_all_stickers_previous_values_on_side("F")
	update_all_stickers_previous_values_on_side("R")
	update_all_stickers_previous_values_on_side("B")
	update_all_stickers_previous_values_on_side("D")
	
	
# The following lines are code for each individual turn/rotation the cube can make.

# Turn the top face clockwise by changing every sticker that will change values due to the turn.
func U():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"D", "B":"A", "C":"B", "D":"C", "a":"d", "b":"a", "c":"b", "d":"c"})
	# Update the left face stickers.
	change_selected_stickers({"E":"I", "F":"J", "e":"i"})
	# Update the front face stickers.
	change_selected_stickers({"I":"M", "J":"N", "i":"m"})
	# Update the right face stickers.
	change_selected_stickers({"M":"Q", "N":"R", "m":"q"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"E", "R":"F", "q":"e"})
	
# Turn the top face counter clockwise by changing every sticker that will change values due to the turn.
func U_CCW():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"B", "B":"C", "C":"D", "D":"A", "a":"b", "b":"c", "c":"d", "d":"a"})
	# Update the left face stickers.
	change_selected_stickers({"E":"Q", "F":"R", "e":"q"})
	# Update the front face stickers.
	change_selected_stickers({"I":"E", "J":"F", "i":"e"})
	# Update the right face stickers.
	change_selected_stickers({"M":"I", "N":"J", "m":"i"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"M", "R":"N", "q":"m"})
	
# Turn the top face 180 degrees by changing every sticker that will change values due to the turn.
func U2():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"C", "B":"D", "C":"A", "D":"B", "a":"c", "b":"d", "c":"a", "d":"b"})
	# Update the left face stickers.
	change_selected_stickers({"E":"M", "F":"N", "e":"m"})
	# Update the front face stickers.
	change_selected_stickers({"I":"Q", "J":"R", "i":"q"})
	# Update the right face stickers.
	change_selected_stickers({"M":"E", "N":"F", "m":"e"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"I", "R":"J", "q":"i"})

# Turn the bottom face clockwise by changing every sticker that will change values due to the turn.
func D():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the left face stickers.
	change_selected_stickers({"G":"S", "H":"T", "g":"s"})
	# Update the front face stickers.
	change_selected_stickers({"K":"G", "L":"H", "k":"g"})
	# Update the right face stickers.
	change_selected_stickers({"O":"K", "P":"L", "o":"k"})
	# Update the back face stickers.
	change_selected_stickers({"S":"O", "T":"P", "s":"o"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"X", "V":"U", "W":"V", "X":"W", "u":"x", "v":"u", "w":"v", "x":"w"})

# Turn the bottom face counter clockwise by changing every sticker that will change values due to the turn.
func D_CCW():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the left face stickers.
	change_selected_stickers({"G":"K", "H":"L", "g":"k"})
	# Update the front face stickers.
	change_selected_stickers({"K":"O", "L":"P", "k":"o"})
	# Update the right face stickers.
	change_selected_stickers({"O":"S", "P":"T", "o":"s"})
	# Update the back face stickers.
	change_selected_stickers({"S":"G", "T":"H", "s":"g"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"V", "V":"W", "W":"X", "X":"U", "u":"v", "v":"w", "w":"x", "x":"u"})

# Turn the bottom face 180 degrees by changing every sticker that will change values due to the turn.
func D2():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the left face stickers.
	change_selected_stickers({"G":"O", "H":"P", "g":"o"})
	# Update the front face stickers.
	change_selected_stickers({"K":"S", "L":"T", "k":"s"})
	# Update the right face stickers.
	change_selected_stickers({"O":"G", "P":"H", "o":"g"})
	# Update the back face stickers.
	change_selected_stickers({"S":"K", "T":"L", "s":"k"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"W", "V":"X", "W":"U", "X":"V", "u":"w", "v":"x", "w":"u", "x":"v"})

# Turn the front face clockwise by changing every sticker that will change values due to the turn.
func F():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"C":"F", "D":"G", "c":"f"})
	# Update the left face stickers.
	change_selected_stickers({"F":"U", "G":"V", "f":"u"})
	# Update the front face stickers.
	change_selected_stickers({"I":"L", "J":"I", "K":"J", "L":"K", "i":"l", "j":"i", "k":"j", "l":"k"})
	# Update the right face stickers.
	change_selected_stickers({"P":"C", "M":"D", "p":"c"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"P", "V":"M", "u":"p"})

# Turn the front face counter clockwise by changing every sticker that will change values due to the turn.
func F_CCW():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"C":"P", "D":"M", "c":"p"})
	# Update the left face stickers.
	change_selected_stickers({"F":"C", "G":"D", "f":"c"})
	# Update the front face stickers.
	change_selected_stickers({"I":"J", "J":"K", "K":"L", "L":"I", "i":"j", "j":"k", "k":"l", "l":"i"})
	# Update the right face stickers.
	change_selected_stickers({"P":"U", "M":"V", "p":"u"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"F", "V":"G", "u":"f"})

# Turn the front face 180 degrees by changing every sticker that will change values due to the turn.
func F2():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"C":"U", "D":"V", "c":"u"})
	# Update the left face stickers.
	change_selected_stickers({"F":"P", "G":"M", "f":"p"})
	# Update the front face stickers.
	change_selected_stickers({"I":"K", "J":"L", "K":"I", "L":"J", "i":"k", "j":"l", "k":"i", "l":"j"})
	# Update the right face stickers.
	change_selected_stickers({"P":"F", "M":"G", "p":"f"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"C", "V":"D", "u":"c"})

# Turn the back face clockwise by changing every sticker that will change values due to the turn.
func B():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"N", "B":"O", "a":"n"})
	# Update the left face stickers.
	change_selected_stickers({"H":"A", "E":"B", "h":"a"})
	# Update the right face stickers.
	change_selected_stickers({"N":"W", "O":"X", "n":"w"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"T", "R":"Q", "S":"R", "T":"S", "q":"t", "r":"q", "s":"r", "t":"s"})
	# Update the bottom face stickers.
	change_selected_stickers({"W":"H", "X":"E", "w":"h"})

# Turn the back face counter clockwise by changing every sticker that will change values due to the turn.
func B_CCW():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"H", "B":"E", "a":"h"})
	# Update the left face stickers.
	change_selected_stickers({"H":"W", "E":"X", "h":"w"})
	# Update the right face stickers.
	change_selected_stickers({"N":"A", "O":"B", "n":"a"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"R", "R":"S", "S":"T", "T":"Q", "q":"r", "r":"s", "s":"t", "t":"q"})
	# Update the bottom face stickers.
	change_selected_stickers({"W":"N", "X":"O", "w":"n"})

# Turn the back face 180 degrees by changing every sticker that will change values due to the turn.
func B2():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"W", "B":"X", "a":"w"})
	# Update the left face stickers.
	change_selected_stickers({"H":"N", "E":"O", "h":"n"})
	# Update the right face stickers.
	change_selected_stickers({"N":"H", "O":"E", "n":"h"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"S", "R":"T", "S":"Q", "T":"R", "q":"s", "r":"t", "s":"q", "t":"r"})
	# Update the bottom face stickers.
	change_selected_stickers({"W":"A", "X":"B", "w":"a"})

# Turn the right face clockwise by changing every sticker that will change values due to the turn.
func R():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"B":"J", "C":"K", "b":"j"})
	# Update the front face stickers.
	change_selected_stickers({"J":"V", "K":"W", "j":"v"})
	# Update the right face stickers.
	change_selected_stickers({"M":"P", "N":"M", "O":"N", "P":"O", "m":"p", "n":"m", "o":"n", "p":"o"})
	# Update the back face stickers.
	change_selected_stickers({"T":"B", "Q":"C", "t":"b"})
	# Update the bottom face stickers.
	change_selected_stickers({"V":"T", "W":"Q", "v":"t"})

# Turn the right face counter clockwise by changing every sticker that will change values due to the turn.
func R_CCW():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"B":"T", "C":"Q", "b":"t"})
	# Update the front face stickers.
	change_selected_stickers({"J":"B", "K":"C", "j":"b"})
	# Update the right face stickers.
	change_selected_stickers({"M":"N", "N":"O", "O":"P", "P":"M", "m":"n", "n":"o", "o":"p", "p":"m"})
	# Update the back face stickers.
	change_selected_stickers({"T":"V", "Q":"W", "t":"v"})
	# Update the bottom face stickers.
	change_selected_stickers({"V":"J", "W":"K", "v":"j"})

# Turn the right face 180 degrees by changing every sticker that will change values due to the turn.
func R2():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"B":"V", "C":"W", "b":"v"})
	# Update the front face stickers.
	change_selected_stickers({"J":"T", "K":"Q", "j":"t"})
	# Update the right face stickers.
	change_selected_stickers({"M":"O", "N":"P", "O":"M", "P":"N", "m":"o", "n":"p", "o":"m", "p":"n"})
	# Update the back face stickers.
	change_selected_stickers({"T":"J", "Q":"K", "t":"j"})
	# Update the bottom face stickers.
	change_selected_stickers({"V":"B", "W":"C", "v":"b"})

# Turn the left face clockwise by changing every sticker that will change values due to the turn.
func L():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"S", "D":"R", "d":"r"})
	# Update the left face stickers.
	change_selected_stickers({"E":"H", "F":"E", "G":"F", "H":"G", "e":"h", "f":"e", "g":"f", "h":"g"})
	# Update the front face stickers.
	change_selected_stickers({"I":"A", "L":"D", "l":"d"})
	# Update the back face stickers.
	change_selected_stickers({"S":"U", "R":"X", "r":"x"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"I", "X":"L", "x":"l"})

# Turn the left face counter clockwise by changing every sticker that will change values due to the turn.
func L_CCW():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"I", "D":"L", "d":"l"})
	# Update the left face stickers.
	change_selected_stickers({"E":"F", "F":"G", "G":"H", "H":"E", "e":"f", "f":"g", "g":"h", "h":"e"})
	# Update the front face stickers.
	change_selected_stickers({"I":"U", "L":"X", "l":"x"})
	# Update the back face stickers.
	change_selected_stickers({"S":"A", "R":"D", "r":"d"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"S", "X":"R", "x":"r"})

# Turn the left face 180 degrees by changing every sticker that will change values due to the turn.
func L2():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"U", "D":"X", "d":"x"})
	# Update the left face stickers.
	change_selected_stickers({"E":"G", "F":"H", "G":"E", "H":"F", "e":"g", "f":"h", "g":"e", "h":"f"})
	# Update the front face stickers.
	change_selected_stickers({"I":"S", "L":"R", "l":"r"})
	# Update the back face stickers.
	change_selected_stickers({"S":"I", "R":"l", "r":"l"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"A", "X":"D", "x":"d"})


# Rotate the entire cube clockwise along the x axis by changing every sticker that will change values due to the rotation.
func X():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"I", "B":"J", "C":"K", "D":"L", "a":"i", "b":"j", "c":"k", "d":"l", "UC":"FC"})
	# Update the left face stickers.
	change_selected_stickers({"E":"F", "F":"G", "G":"H", "H":"E", "e":"f", "f":"g", "g":"h", "h":"e"})
	# Update the front face stickers.
	change_selected_stickers({"I":"U", "J":"V", "K":"W", "L":"X", "i":"u", "j":"v", "k":"w", "l":"x", "FC":"DC"})
	# Update the right face stickers.
	change_selected_stickers({"M":"P", "N":"M", "O":"N", "P":"O", "m":"p", "n":"m", "o":"n", "p":"o"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"C", "R":"D", "S":"A", "T":"B", "q":"c", "r":"d", "s":"a", "t":"b", "BC":"UC"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"S", "V":"T", "W":"Q", "X":"R", "u":"s", "v":"t", "w":"q", "x":"r", "DC":"BC"})
	
# Rotate the entire cube counter clockwise along the X axis by changing every sticker that will change values due to the rotation.
func X_CCW():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"S", "B":"T", "C":"Q", "D":"R", "a":"s", "b":"t", "c":"q", "d":"r", "UC":"BC"})
	# Update the left face stickers.
	change_selected_stickers({"E":"H", "F":"E", "G":"F", "H":"G", "e":"h", "f":"e", "g":"f", "h":"g"})
	# Update the front face stickers.
	change_selected_stickers({"I":"A", "J":"B", "K":"C", "L":"D", "i":"a", "j":"b", "k":"c", "l":"d", "FC":"UC"})
	# Update the right face stickers.
	change_selected_stickers({"M":"N", "N":"O", "O":"P", "P":"M", "m":"n", "n":"o", "o":"p", "p":"m"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"W", "R":"X", "S":"U", "T":"V", "q":"w", "r":"x", "s":"u", "t":"v", "BC":"DC"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"I", "V":"J", "W":"K", "X":"L", "u":"i", "v":"j", "w":"k", "x":"l", "DC":"FC"})
	
# Rotate the entire cube 180 degrees along the x axis by changing every sticker that will change values due to the rotation.
func X2():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"U", "B":"V", "C":"W", "D":"X", "a":"u", "b":"v", "c":"w", "d":"x", "UC":"DC"})
	# Update the left face stickers.
	change_selected_stickers({"E":"G", "F":"H", "G":"E", "H":"F", "e":"g", "f":"h", "g":"e", "h":"f"})
	# Update the front face stickers.
	change_selected_stickers({"I":"S", "J":"T", "K":"Q", "L":"R", "i":"s", "j":"t", "k":"q", "l":"r", "FC":"BC"})
	# Update the right face stickers.
	change_selected_stickers({"M":"O", "N":"P", "O":"M", "P":"N", "m":"o", "n":"p", "o":"m", "p":"n"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"K", "R":"L", "S":"I", "T":"J", "q":"k", "r":"l", "s":"i", "t":"j", "BC":"FC"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"A", "V":"B", "W":"C", "X":"D", "u":"a", "v":"b", "w":"c", "x":"d", "DC":"UC"})
	
# Rotate the entire cube clockwise along the y axis by changing every sticker that will change values due to the rotation.
func Y():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"D", "B":"A", "C":"B", "D":"C", "a":"d", "b":"a", "c":"b", "d":"c"})
	# Update the left face stickers.
	change_selected_stickers({"E":"I", "F":"J", "G":"K", "H":"L", "e":"i", "f":"j", "g":"k", "h":"l", "LC":"FC"})
	# Update the front face stickers.
	change_selected_stickers({"I":"M", "J":"N", "K":"O", "L":"P", "i":"m", "j":"n", "k":"o", "l":"p", "FC":"RC"})
	# Update the right face stickers.
	change_selected_stickers({"M":"Q", "N":"R", "O":"S", "P":"T", "m":"q", "n":"r", "o":"s", "p":"t", "RC":"BC"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"E", "R":"F", "S":"G", "T":"H", "q":"e", "r":"f", "s":"g", "t":"h", "BC":"LC"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"V", "V":"W", "W":"X", "X":"U", "u":"v", "v":"w", "w":"x", "x":"u"})
	
# Rotate the entire cube counter clockwise along the y axis by changing every sticker that will change values due to the rotation.
func Y_CCW():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"B", "B":"C", "C":"D", "D":"A", "a":"b", "b":"c", "c":"d", "d":"a"})
	# Update the left face stickers.
	change_selected_stickers({"E":"Q", "F":"R", "G":"S", "H":"T", "e":"q", "f":"r", "g":"s", "h":"t", "LC":"BC"})
	# Update the front face stickers.
	change_selected_stickers({"I":"E", "J":"F", "K":"G", "L":"H", "i":"e", "j":"f", "k":"g", "l":"h", "FC":"LC"})
	# Update the right face stickers.
	change_selected_stickers({"M":"I", "N":"J", "O":"K", "P":"L", "m":"i", "n":"j", "o":"k", "p":"l", "RC":"FC"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"M", "R":"N", "S":"O", "T":"P", "q":"m", "r":"n", "s":"o", "t":"p", "BC":"RC"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"X", "V":"U", "W":"V", "X":"W", "u":"x", "v":"u", "w":"v", "x":"w"})
	
# Rotate the entire cube 180 degrees along the y axis by changing every sticker that will change values due to the rotation.
func Y2():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"C", "B":"D", "C":"A", "D":"B", "a":"c", "b":"d", "c":"a", "d":"b"})
	# Update the left face stickers.
	change_selected_stickers({"E":"M", "F":"N", "G":"O", "H":"P", "e":"m", "f":"n", "g":"o", "h":"p", "LC":"RC"})
	# Update the front face stickers.
	change_selected_stickers({"I":"Q", "J":"R", "K":"S", "L":"T", "i":"q", "j":"r", "k":"s", "l":"t", "FC":"BC"})
	# Update the right face stickers.
	change_selected_stickers({"M":"E", "N":"F", "O":"G", "P":"H", "m":"e", "n":"f", "o":"g", "p":"h", "RC":"LC"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"I", "R":"J", "S":"K", "T":"L", "q":"i", "r":"j", "s":"k", "t":"l", "BC":"FC"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"W", "V":"X", "W":"U", "X":"V", "u":"w", "v":"x", "w":"u", "x":"v"})
	
# Rotate the entire cube clockwise along the z axis by changing every sticker that will change values due to the rotation.
func Z():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"H", "B":"E", "C":"F", "D":"G", "a":"h", "b":"e", "c":"f", "d":"g", "UC":"LC"})
	# Update the left face stickers.
	change_selected_stickers({"E":"X", "F":"U", "G":"V", "H":"W", "e":"x", "f":"u", "g":"v", "h":"w", "LC":"DC"})
	# Update the front face stickers.
	change_selected_stickers({"I":"L", "J":"I", "K":"J", "L":"K", "i":"l", "j":"i", "k":"j", "l":"k"})
	# Update the right face stickers.
	change_selected_stickers({"M":"D", "N":"A", "O":"B", "P":"C", "m":"d", "n":"a", "o":"b", "p":"c", "RC":"UC"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"R", "R":"S", "S":"T", "T":"Q", "q":"r", "r":"s", "s":"t", "t":"q"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"P", "V":"M", "W":"N", "X":"O", "u":"p", "v":"m", "w":"n", "x":"o", "DC":"RC"})
	
# Rotate the entire cube counter clockwise along the z axis by changing every sticker that will change values due to the rotation.
func Z_CCW():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"N", "B":"O", "C":"P", "D":"M", "a":"n", "b":"o", "c":"p", "d":"m", "UC":"RC"})
	# Update the left face stickers.
	change_selected_stickers({"E":"B", "F":"C", "G":"D", "H":"A", "e":"b", "f":"c", "g":"d", "h":"a", "LC":"UC"})
	# Update the front face stickers.
	change_selected_stickers({"I":"J", "J":"K", "K":"L", "L":"I", "i":"j", "j":"k", "k":"l", "l":"i"})
	# Update the right face stickers.
	change_selected_stickers({"M":"V", "N":"W", "O":"X", "P":"U", "m":"v", "n":"w", "o":"x", "p":"u", "RC":"DC"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"T", "R":"Q", "S":"R", "T":"S", "q":"t", "r":"q", "s":"r", "t":"s"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"F", "V":"G", "W":"H", "X":"E", "u":"f", "v":"g", "w":"h", "x":"e", "DC":"LC"})
	
# Rotate the entire cube 180 degrees along the z axis by changing every sticker that will change values due to the rotation.
func Z2():
	# Updating the previous value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"W", "B":"X", "C":"U", "D":"V", "a":"w", "b":"x", "c":"u", "d":"v", "UC":"DC"})
	# Update the left face stickers.
	change_selected_stickers({"E":"O", "F":"P", "G":"M", "H":"N", "e":"o", "f":"p", "g":"m", "h":"n", "LC":"RC"})
	# Update the front face stickers.
	change_selected_stickers({"I":"K", "J":"L", "K":"I", "L":"J", "i":"k", "j":"l", "k":"i", "l":"j"})
	# Update the right face stickers.
	change_selected_stickers({"M":"G", "N":"H", "O":"E", "P":"F", "m":"g", "n":"h", "o":"e", "p":"f", "RC":"LC"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"S", "R":"T", "S":"Q", "T":"R", "q":"s", "r":"t", "s":"q", "t":"r"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"C", "V":"D", "W":"A", "X":"B", "u":"c", "v":"d", "w":"a", "x":"b", "DC":"UC"})


# This function will tell you the name of the corner that is at the specified location you give it. The argument is the location of a sticker on that corner piece location.
func find_corner_identity(sticker):
	# Use the helper function to give us the corner name. The different arguements that it takes, are the sticker locations of all the stickers on the piece.
	match sticker:
		"A", "E", "R":
			return(organize_corner_colors("%s%s%s" % [STICKER_VALUES["A"], STICKER_VALUES["E"], STICKER_VALUES["R"]]))
		"B", "Q", "N":
			return(organize_corner_colors("%s%s%s" % [STICKER_VALUES["B"], STICKER_VALUES["Q"], STICKER_VALUES["N"]]))
		"C", "M", "J":
			return(organize_corner_colors("%s%s%s" % [STICKER_VALUES["C"], STICKER_VALUES["M"], STICKER_VALUES["J"]]))
		"D", "I", "F":
			return(organize_corner_colors("%s%s%s" % [STICKER_VALUES["D"], STICKER_VALUES["I"], STICKER_VALUES["F"]]))
		"U", "G", "L":
			return(organize_corner_colors("%s%s%s" % [STICKER_VALUES["U"], STICKER_VALUES["G"], STICKER_VALUES["L"]]))
		"V", "K", "P":
			return(organize_corner_colors("%s%s%s" % [STICKER_VALUES["V"], STICKER_VALUES["K"], STICKER_VALUES["P"]]))
		"W", "O", "T":
			return(organize_corner_colors("%s%s%s" % [STICKER_VALUES["W"], STICKER_VALUES["O"], STICKER_VALUES["T"]]))
		"X", "S", "H":
			return(organize_corner_colors("%s%s%s" % [STICKER_VALUES["X"], STICKER_VALUES["S"], STICKER_VALUES["H"]]))
		_:
			print("Find corner identity error")
			
# This function will take a string that has 3 letters in it (each corresponding to a specific color.) and tells you the name of the corner that has those 3 colors. (This is a helper function for the find_corner_identity() function.)
func organize_corner_colors(letters):
	# First, check to see if the corner is from the top or bottom layer.
	if letters.contains("W"):
		# Second, check to see if the corner is from the front layer.
		if letters.contains("G"):
			# Third, check to see if the corner if from the right side layer.
			if letters.contains("R"):
				# The corner is the italian (white, green, and red corner).
				return get_parent().get_node("Corners").get_node("ItalianCorner")
			# The corner is the irish corner (white, green, orange).
			else:
				return get_parent().get_node("Corners").get_node("IrishCorner")
		# The corner contains white and blue. Check to see if the third color is red or orange.
		else:
			if letters.contains("R"):
				# The corner is the usa corner (white, blue, red).
				return get_parent().get_node("Corners").get_node("USACorner")
			# The corner is the netherlands corner (white, blue, orange).
			else:
				return get_parent().get_node("Corners").get_node("NetherlandsCorner")
	# The corner is from the bottom layer (contains yellow).
	else:
		# Second, check to see if the corner is from the front layer.
		if letters.contains("G"):
			# Third, check to see if the corner if from the right side layer.
			if letters.contains("R"):
				# The corner is the bob marley corner (yellow, green, and red corner).
				return get_parent().get_node("Corners").get_node("BobMarleyCorner")
			# The corner is the sprite corner (yellow, green, orange).
			else:
				return get_parent().get_node("Corners").get_node("SpriteCorner")
		# The corner contains yellow and blue. Check to see if the third color is red or orange.
		else:
			if letters.contains("R"):
				# The corner is the primary corner (yellow, blue, red).
				return get_parent().get_node("Corners").get_node("PrimaryCorner")
			# The corner is the nerf corner (yellow, blue, orange).
			else:
				return get_parent().get_node("Corners").get_node("NerfCorner")

# This function will find the name of the edge at the edge location you give it. The argument is just one of the edge sticker locations. (It will return the name of the entire edge that is at that sticker location.)
func find_edge_identity(location):
	# Make a string variable that will contain the 2 colors on the edge.
	var colors = ""
	# Use a match statement to find out which edge location is being used. Then find the colors at the sticker locations on the piece that has the given sticker location.
	match location:
		"a", "q":
			colors = "%s%s" % [STICKER_VALUES["a"], STICKER_VALUES["q"]]
		"b", "m":
			colors = "%s%s" % [STICKER_VALUES["b"], STICKER_VALUES["m"]]
		"c", "i":
			colors = "%s%s" % [STICKER_VALUES["c"], STICKER_VALUES["i"]]
		"d", "e":
			colors = "%s%s" % [STICKER_VALUES["d"], STICKER_VALUES["e"]]
		"h", "r":
			colors = "%s%s" % [STICKER_VALUES["h"], STICKER_VALUES["r"]]
		"f", "l":
			colors = "%s%s" % [STICKER_VALUES["f"], STICKER_VALUES["l"]]
		"n", "t":
			colors = "%s%s" % [STICKER_VALUES["n"], STICKER_VALUES["t"]]
		"j", "p":
			colors = "%s%s" % [STICKER_VALUES["j"], STICKER_VALUES["p"]]
		"u", "k":
			colors = "%s%s" % [STICKER_VALUES["u"], STICKER_VALUES["k"]]
		"v", "o":
			colors = "%s%s" % [STICKER_VALUES["v"], STICKER_VALUES["o"]]
		"w", "s":
			colors = "%s%s" % [STICKER_VALUES["w"], STICKER_VALUES["s"]]
		"x", "g":
			colors = "%s%s" % [STICKER_VALUES["x"], STICKER_VALUES["g"]]
	# Now check if the string is formatted correctly. (Correct format is "W" or "Y" as the first letter. If there is no "W" or "Y", then "G" or "B" should be first.)
	if colors[0] == "W" or "Y":
		# The first letter is "W" or "Y" so the string is formatted correctly and the colors string can be returned.
		return(edges.get_node(colors))
	elif colors[1] == "W" or "Y":
		# The second letter is "W" or "Y" so the first and second letter will be swapped so that the string is formatted correctly. Then the string will be returned.
		return(edges.get_node(colors.reverse()))
	elif colors[0] == "G" or "B":
		# The string does not contain "W" or "Y". It has "G" or "B" as the first letter, so it is formatted correctly. The string will be returned.
		return(edges.get_node(colors))
	elif colors[1] == "G" or "B":
		# The string does not contain "W" or "Y". It has "G" or "B" as the second letter so the string will be reversed and then returned.
		return(edges.get_node(colors.reverse()))
	else:
		# this should never happen. If it does, I"m in trouble...
		print("This is an error that should never happen... Check the find_edge_identity() function in cube logic.")
		return("00")
		
# This function will find the center piece that is at the center sticker location you specify as an arguement.
func find_center_identity(location):
	# Make a variable to hold the color of the sticker at the location. Find the color by checking the location as a key in STICKER_VALUES
	var color = STICKER_VALUES[location]
	# Use a match to convert the color name to the corresponding center piece.
	match color:
		"W":
			# The color is white, so return the white center node.
			return(get_parent().get_node("Centers").get_node("WhiteCenter"))
		"O":
			# The color is orange, so return the orange center node.
			return(get_parent().get_node("Centers").get_node("OrangeCenter"))
		"G":
			# The color is green, so return the green center node.
			return(get_parent().get_node("Centers").get_node("GreenCenter"))
		"R":
			# The color is red, so return the red center node.
			return(get_parent().get_node("Centers").get_node("RedCenter"))
		"B":
			# The color is blue, so return the blue center node.
			return(get_parent().get_node("Centers").get_node("BlueCenter"))
		"Y":
			# The color is yellow, so return the yellow center node.
			return(get_parent().get_node("Centers").get_node("YellowCenter"))
		_:
			print("find center identity error")
		
# This function will find all the pieces in a specified layer (arguement), and will return them to you in a list,
func find_pieces_in_layer(layer):
	# Make a list to hold all of the pieces.
	var pieces = []
	# Figure out what layer is being used by using a match statement.
	match layer:
		"U":
			# The layer is the top layer. Go through all the locations on the top side and add those pieces to the list.
			for location in LOCATION_LIST[0][0]:
				pieces.append(find_corner_identity(location))
			# Then, find go through all the edges and add them to the list.
			for location in LOCATION_LIST[0][1]:
				pieces.append(find_edge_identity(location))
			# Finally, add the center to the list.
			pieces.append(find_center_identity(LOCATION_LIST[0][2]))
		"L":
			# The layer is the left layer. Go through all the locations on the left side and add those pieces to the list.
			for location in LOCATION_LIST[1][0]:
				pieces.append(find_corner_identity(location))
			# Then, find go through all the edges and add them to the list.
			for location in LOCATION_LIST[1][1]:
				pieces.append(find_edge_identity(location))
			# Finally, add the center to the list.
			pieces.append(LOCATION_LIST[1][2])
		"F":
			# The layer is the front layer. Go through all the locations on the front side and add those pieces to the list.
			for location in LOCATION_LIST[2][0]:
				pieces.append(find_corner_identity(location))
			# Then, find go through all the edges and add them to the list.
			for location in LOCATION_LIST[2][1]:
				pieces.append(find_edge_identity(location))
			# Finally, add the center to the list.
			pieces.append(LOCATION_LIST[2][2])
		"R":
			# The layer is the right layer. Go through all the locations on the right side and add those pieces to the list.
			for location in LOCATION_LIST[3][0]:
				pieces.append(find_corner_identity(location))
			# Then, find go through all the edges and add them to the list.
			for location in LOCATION_LIST[3][1]:
				pieces.append(find_edge_identity(location))
			# Finally, add the center to the list.
			pieces.append(LOCATION_LIST[3][2])
		"B":
			# The layer is the back layer. Go through all the locations on the back side and add those pieces to the list.
			for location in LOCATION_LIST[4][0]:
				pieces.append(find_corner_identity(location))
			# Then, find go through all the edges and add them to the list.
			for location in LOCATION_LIST[4][1]:
				pieces.append(find_edge_identity(location))
			# Finally, add the center to the list.
			pieces.append(LOCATION_LIST[4][2])
		"D":
			# The layer is the bottom layer. Go through all the locations on the bottom side and add those pieces to the list.
			for location in LOCATION_LIST[5][0]:
				pieces.append(find_corner_identity(location))
			# Then, find go through all the edges and add them to the list.
			for location in LOCATION_LIST[5][1]:
				pieces.append(find_edge_identity(location))
			# Finally, add the center to the list.
			pieces.append(LOCATION_LIST[5][2])
	# Now return the list of parts that has been made.
	return(pieces)
