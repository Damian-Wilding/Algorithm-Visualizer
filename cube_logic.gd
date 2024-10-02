extends Node3D

# This dictionary keeps track of every sticker's color. (Capital letter means corner sticker, lowercase letter means edge sticker, and 2 capital letters represent center stickers. This follows the Spef's lettering scheme used in blindfolded Rubik's cube solving.)
var STICKER_VALUES = {"A":"", "B":"", "C":"", "D":"", "E":"", "F":"", "G":"", "H":"", "I":"", "J":"", "K":"", "L":"", "M":"", "N":"", "O":"", "P":"", "Q":"", "R":"", "S":"", "T":"", "U":"", "V":"", "W":"", "X":"", "a":"", "b":"", "c":"", "d":"", "e":"", "f":"", "g":"", "h":"", "i":"", "j":"", "k":"", "l":"", "m":"", "n":"", "o":"", "p":"", "q":"", "r":"", "s":"", "t":"", "u":"", "v":"", "w":"", "x":"", "TC":"","LC":"", "FC":"", "RC":"", "BC":"", "DC":""}
# This dictionary is the exact same, but it will be the values of the stickers after the previous turn has been made. (It's used to find the new color to set a sticker to.)
var PREVIOUS_STICKER_VALUES = {"A":"", "B":"", "C":"", "D":"", "E":"", "F":"", "G":"", "H":"", "I":"", "J":"", "K":"", "L":"", "M":"", "N":"", "O":"", "P":"", "Q":"", "R":"", "S":"", "T":"", "U":"", "V":"", "W":"", "X":"", "a":"", "b":"", "c":"", "d":"", "e":"", "f":"", "g":"", "h":"", "i":"", "j":"", "k":"", "l":"", "m":"", "n":"", "o":"", "p":"", "q":"", "r":"", "s":"", "t":"", "u":"", "v":"", "w":"", "x":"", "TC":"","LC":"", "FC":"", "RC":"", "BC":"", "DC":""}

# Called when the node enters the scene tree for the first time.
func _ready():
	# Assign the right colors to all of the stickers. (Always starts with the white side on top and the green side in the front.)
	# White side stickers.
	set_sides_colors("T", "W", "W", "W", "W", "W", "W", "W", "W", "W")
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
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
# Set all the sticker's colors on any given side. The first argument is the side, and the rest are the desired colors for each sticker.
func set_sides_colors(side, center, corner1, corner2, corner3, corner4, edge1, edge2, edge3, edge4):
	match side:
		"T":
			STICKER_VALUES.TC = center
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
		"T":
			PREVIOUS_STICKER_VALUES.TC = STICKER_VALUES.TC
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
	update_all_stickers_previous_values_on_side("T")
	update_all_stickers_previous_values_on_side("L")
	update_all_stickers_previous_values_on_side("F")
	update_all_stickers_previous_values_on_side("R")
	update_all_stickers_previous_values_on_side("B")
	update_all_stickers_previous_values_on_side("D")
	
	
# The following lines are code for each individual turn/rotation the cube can make.

# Turn the top face clockwise by changing every sticker that will change values due to the turn.
func U():
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
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
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"I", "B":"J", "C":"K", "D":"L", "a":"i", "b":"j", "c":"k", "d":"l", "TC":"FC"})
	# Update the left face stickers.
	change_selected_stickers({"E":"F", "F":"G", "G":"H", "H":"E", "e":"f", "f":"g", "g":"h", "h":"e"})
	# Update the front face stickers.
	change_selected_stickers({"I":"U", "J":"V", "K":"W", "L":"X", "i":"u", "j":"v", "k":"w", "l":"x", "FC":"DC"})
	# Update the right face stickers.
	change_selected_stickers({"M":"P", "N":"M", "O":"N", "P":"O", "m":"p", "n":"m", "o":"n", "p":"o"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"C", "R":"D", "S":"A", "T":"B", "q":"c", "r":"d", "s":"a", "t":"b", "BC":"TC"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"S", "V":"T", "W":"Q", "X":"R", "u":"s", "v":"t", "w":"q", "x":"r", "DC":"BC"})
	
# Rotate the entire cube counter clockwise along the X axis by changing every sticker that will change values due to the rotation.
func X_CCW():
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"S", "B":"T", "C":"Q", "D":"R", "a":"s", "b":"t", "c":"q", "d":"r", "TC":"BC"})
	# Update the left face stickers.
	change_selected_stickers({"E":"H", "F":"E", "G":"F", "H":"G", "e":"h", "f":"e", "g":"f", "h":"g"})
	# Update the front face stickers.
	change_selected_stickers({"I":"A", "J":"B", "K":"C", "L":"D", "i":"a", "j":"b", "k":"c", "l":"d", "FC":"TC"})
	# Update the right face stickers.
	change_selected_stickers({"M":"N", "N":"O", "O":"P", "P":"M", "m":"n", "n":"o", "o":"p", "p":"m"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"W", "R":"X", "S":"U", "T":"V", "q":"w", "r":"x", "s":"u", "t":"v", "BC":"DC"})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"I", "V":"J", "W":"K", "X":"L", "u":"i", "v":"j", "w":"k", "x":"l", "DC":"FC"})
	
# Rotate the entire cube 180 degrees along the x axis by changing every sticker that will change values due to the rotation.
func X2():
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"U", "B":"V", "C":"W", "D":"X", "a":"u", "b":"v", "c":"w", "d":"x", "TC":"DC"})
	# Update the left face stickers.
	change_selected_stickers({"E":"G", "F":"H", "G":"E", "H":"F", "e":"g", "f":"h", "g":"e", "h":"f"})
	# Update the front face stickers.
	change_selected_stickers({"I":"S", "J":"T", "K":"Q", "L":"R", "i":"s", "j":"t", "k":"q", "l":"r", "FC":"BC"})
	# Update the right face stickers.
	change_selected_stickers({"M":"O", "N":"P", "O":"M", "P":"N", "m":"o", "n":"p", "o":"m", "p":"n"})
	# Update the back face stickers.
	change_selected_stickers({"Q":"", "R":"", "S":"", "T":"", "q":"", "r":"", "s":"", "t":"", "BC":""})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"", "V":"", "W":"", "X":"", "u":"", "v":"", "w":"", "x":"", "DC":""})
	
# Rotate the entire cube clockwise along the y axis by changing every sticker that will change values due to the rotation.
func Y():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube counter clockwise along the y axis by changing every sticker that will change values due to the rotation.
func Y_CCW():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube 180 degrees along the y axis by changing every sticker that will change values due to the rotation.
func Y2():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube clockwise along the z axis by changing every sticker that will change values due to the rotation.
func Z():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube counter clockwise along the z axis by changing every sticker that will change values due to the rotation.
func Z_CCW():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube 180 degrees along the z axis by changing every sticker that will change values due to the rotation.
func Z2():
	# Rearrange the stickers to update piece positions.
	pass



#	change_selected_stickers({"":"", "":"", "":"", "":"", "":"", "":"", "":"", "":""})
#	change_selected_stickers({"":"", "":"", "":""})

# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
	update_all_stickers()
	# Update the top face stickers.
	change_selected_stickers({"A":"", "B":"", "C":"", "D":"", "a":"", "b":"", "c":"", "d":"", "TC":""})
	# Update the left face stickers.
	change_selected_stickers({"E":"", "F":"", "G":"", "H":"", "e":"", "f":"", "g":"", "h":"", "LC":""})
	# Update the front face stickers.
	change_selected_stickers({"I":"", "J":"", "K":"", "L":"", "i":"", "j":"", "k":"", "l":"", "FC":""})
	# Update the right face stickers.
	change_selected_stickers({"M":"", "N":"", "O":"", "P":"", "m":"", "n":"", "o":"", "p":"", "RC":""})
	# Update the back face stickers.
	change_selected_stickers({"Q":"", "R":"", "S":"", "T":"", "q":"", "r":"", "s":"", "t":"", "BC":""})
	# Update the bottom face stickers.
	change_selected_stickers({"U":"", "V":"", "W":"", "X":"", "u":"", "v":"", "w":"", "x":"", "DC":""})
#
