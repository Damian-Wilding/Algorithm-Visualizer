extends Node3D

# This dictionary keeps track of every sticker's color. (Capital letter means corner sticker, lowercase letter means edge sticker, and 2 capital letters represent center stickers. This follows the Spef's lettering scheme used in blindfolded Rubik's cube solving.)
var STICKER_VALUES = {"A":"", "B":"", "C":"", "D":"", "E":"", "F":"", "G":"", "H":"", "I":"", "J":"", "K":"", "L":"", "M":"", "N":"", "O":"", "P":"", "Q":"", "R":"", "S":"", "T":"", "U":"", "V":"", "W":"", "X":"", "a":"", "b":"", "c":"", "d":"", "e":"", "f":"", "g":"", "h":"", "i":"", "j":"", "k":"", "l":"", "m":"", "n":"", "o":"", "p":"", "q":"", "r":"", "s":"", "t":"", "u":"", "v":"", "w":"", "x":"", "TC":"","LC":"", "FC":"", "RC":"", "BC":"", "DC":""}
# Called when the node enters the scene tree for the first time.
func _ready():
	# Assign the right colors to all of the stickers.
	# White side stickers.
	set_sides_colors($TopSide, $TopSide/TopCenterColor, "W", $TopSide/A_CornerColor, "W", $TopSide/B_CornerColor, "W", $TopSide/C_CornerColor, "W", $TopSide/D_CornerColor, "W", $TopSide/A_EdgeColor, "W", $TopSide/B_EdgeColor, "W", $TopSide/C_EdgeColor, "W", $TopSide/D_EdgeColor, "W")
	# Yellow side stickers.						
	set_sides_colors($Bottom_Side, $Bottom_Side/CenterColor, "Y", $Bottom_Side/A_CornerColor, "Y", $Bottom_Side/B_CornerColor, "Y", $Bottom_Side/C_CornerColor, "Y", $Bottom_Side/D_CornerColor, "Y", $Bottom_Side/A_EdgeColor, "Y", $Bottom_Side/B_EdgeColor, "Y", $Bottom_Side/C_EdgeColor, "Y", $Bottom_Side/D_EdgeColor, "Y")
	# Green side stickers.						
	set_sides_colors($FrontSide, $FrontSide/CenterColor, "G", $FrontSide/A_CornerColor, "G", $FrontSide/B_CornerColor, "G", $FrontSide/C_CornerColor, "G", $FrontSide/D_CornerColor, "G", $FrontSide/A_EdgeColor, "G", $FrontSide/B_EdgeColor, "G", $FrontSide/C_EdgeColor, "G", $FrontSide/D_EdgeColor, "G")
	# Blue side stickers.						
	set_sides_colors($BackSide, $BackSide/CenterColor, "B", $BackSide/A_CornerColor, "B", $BackSide/B_CornerColor, "B", $BackSide/C_CornerColor, "B", $BackSide/D_CornerColor, "B", $BackSide/A_EdgeColor, "B", $BackSide/B_EdgeColor, "B", $BackSide/C_EdgeColor, "B", $BackSide/D_EdgeColor, "B")
	# Red side stickers.						
	set_sides_colors($RightSide, $RightSide/CenterColor, "R", $RightSide/A_CornerColor, "R", $RightSide/B_CornerColor, "R", $RightSide/C_CornerColor, "R", $RightSide/D_CornerColor, "R", $RightSide/A_EdgeColor, "R", $RightSide/B_EdgeColor, "R", $RightSide/C_EdgeColor, "R", $RightSide/D_EdgeColor, "R")
	# Orange side stickers.						
	set_sides_colors($LeftSide, $LeftSide/CenterColor, "O", $LeftSide/A_CornerColor, "O", $LeftSide/B_CornerColor, "O", $LeftSide/C_CornerColor, "O", $LeftSide/D_CornerColor, "O", $LeftSide/A_EdgeColor, "O", $LeftSide/B_EdgeColor, "O", $LeftSide/C_EdgeColor, "O", $LeftSide/D_EdgeColor, "O")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
# Set all the colors on any given side.
func set_sides_colors(side, center, center_color, first_corner, first_corner_color, second_corner, second_corner_color, third_corner, third_corner_color, fourth_corner, fourth_corner_color, first_edge, first_edge_color, second_edge, second_edge_color, third_edge, third_edge_color, fourth_edge, fourth_edge_color):
	# Set the center's color.
	side.center = center_color
	# Set the corner colors.
	side.first_corner = first_corner_color
	side.second_corner = second_corner_color
	side.third_corner = third_corner_color
	side.fourth_corner = fourth_corner_color
	# Set the edge colors.
	side.first_edge = first_edge_color
	side.second_edge = second_edge_color
	side.third_edge = third_edge_color
	side.fourth_edge = fourth_edge_color

# This function takes a dictionary and a list. The dictionary tells us the previous and current color of every sticker on the cube. The list tells us the changes that need to be made to the dictionary.
func change_selected_stickers(sticker_values, values_to_update):
	pass


# This function takes the current value of every sticker on the provided side and sets the previous color of the sticker to be equal to that value.
func update_sides_stickers(side):
	# This iterates through every sticker and changes their previous sticker color value.
	for sticker in side.get_children():
		sticker.LAST_STICKER_COLOR = sticker.STICKER_COLOR
		
# This function updates all the stickers on every side by applying update_sides_stickers() to each of the 6 sides.
func update_all_sides_stickers():
	# This iterates through every side and calls update_sides_stickers() on each of them.
	for side in self.get_children():
		update_sides_stickers(side)
	
	
# The following lines are code for each individual turn/rotation the cube can make.

# Turn the top face clockwise.
func U():
	# Rearrange the stickers to update piece positions.
	# Updating the LAST_STICKER_COLOR value for every sticker on the cube.
	update_all_sides_stickers()
	# Update the top face stickers.
	set_sides_colors($TopSide, $TopSide/TopCenterColor, $TopSide/TopCenterColor.LAST_STICKER_COLOR, $TopSide/A_CornerColor, $TopSide/D_CornerColor.LAST_STICKER_COLOR, $TopSide/B_CornerColor, $TopSide/A_CornerColor.LAST_STICKER_COLOR, $TopSide/C_CornerColor, $TopSide/B_CornerColor.LAST_STICKER_COLOR, $TopSide/D_CornerColor, $TopSide/C_CornerColor.LAST_STICKER_COLOR, $TopSide/A_EdgeColor, $TopSide/D_EdgeColor.LAST_STICKER_COLOR, $TopSide/B_EdgeColor, $TopSide/A_EdgeColor.LAST_STICKER_COLOR, $TopSide/C_EdgeColor, $TopSide/B_EdgeColor.LAST_STICKER_COLOR, $TopSide/D_EdgeColor, $TopSide/C_EdgeColor.LAST_STICKER_COLOR)
	# Update the left face stickers.
	set_sides_colors($LeftSide, $LeftSide/LeftCenterColor, $LeftSide/LeftCenterColor.LAST_STICKER_COLOR, $LeftSide/E_CornerColor, $FrontSide/I_CornerColor.LAST_STICKER_COLOR, $LeftSide/F_CornerColor, $FrontSide/J_CornerColor.LAST_STICKER_COLOR, $LeftSide/G_CornerColor, $LeftSide/G_CornerColor.LAST_STICKER_COLOR, $LeftSide/H_CornerColor, $LeftSide/H_CornerColor.LAST_STICKER_COLOR, $LeftSide/E_EdgeColor, $FrontSide/I_EdgeColor.LAST_STICKER_COLOR, $LeftSide/F_EdgeColor, $LeftSide/F_EdgeColor.LAST_STICKER_COLOR, $LeftSide/G_EdgeColor, $LeftSide/G_EdgeColor.LAST_STICKER_COLOR, $LeftSide/H_EdgeColor, $LeftSide/H_EdgeColor.LAST_STICKER_COLOR)
	# Update the front face stickers.
	set_sides_colors($FrontSide, $FrontSide/FrontCenterColor, $FrontSide/TopCenterColor.LAST_STICKER_COLOR, $FrontSide/I_CornerColor, $RightSide/M_CornerColor.LAST_STICKER_COLOR, $FrontSide/J_CornerColor, $RightSide/N_CornerColor.LAST_STICKER_COLOR, $FrontSide/K_CornerColor, $FrontSide/K_CornerColor.LAST_STICKER_COLOR, $FrontSide/L_CornerColor, $FrontSide/L_CornerColor.LAST_STICKER_COLOR, $FrontSide/I_EdgeColor, $RightSide/M_EdgeColor.LAST_STICKER_COLOR, $FrontSide/J_EdgeColor, $FrontSide/J_EdgeColor.LAST_STICKER_COLOR, $FrontSide/K_EdgeColor, $FrontSide/K_EdgeColor.LAST_STICKER_COLOR, $FrontSide/L_EdgeColor, $FrontSide/L_EdgeColor.LAST_STICKER_COLOR)
	# Update the right face stickers.
	set_sides_colors($RightSide, $RightSide/RightCenterColor, $RightSide/RightCenterColor.LAST_STICKER_COLOR, $RightSide/M_CornerColor, $BackSide/Q_CornerColor.LAST_STICKER_COLOR, $RightSide/N_CornerColor, $BackSide/R_CornerColor.LAST_STICKER_COLOR, $RightSide/O_CornerColor, $RightSide/O_CornerColor.LAST_STICKER_COLOR, $RightSide/P_CornerColor, $RightSide/P_CornerColor.LAST_STICKER_COLOR, $RightSide/M_EdgeColor, $BackSide/Q_EdgeColor.LAST_STICKER_COLOR, $RightSide/N_EdgeColor, $RightSide/N_EdgeColor.LAST_STICKER_COLOR, $RightSide/O_EdgeColor, $RightSide/O_EdgeColor.LAST_STICKER_COLOR, $RightSide/P_EdgeColor, $RightSide/P_EdgeColor.LAST_STICKER_COLOR)
	# Update the back face stickers.
	set_sides_colors($BackSide, $BackSide/BackCenterColor, $BackSide/BackCenterColor.LAST_STICKER_COLOR, $BackSide/Q_CornerColor, $BackSide/_CornerColor.LAST_STICKER_COLOR, $BackSide/B_CornerColor, $BackSide/A_CornerColor.LAST_STICKER_COLOR, $BackSide/C_CornerColor, $BackSide/B_CornerColor.LAST_STICKER_COLOR, $BackSide/D_CornerColor, $BackSide/C_CornerColor.LAST_STICKER_COLOR, $BackSide/A_EdgeColor, $BackSide/D_EdgeColor.LAST_STICKER_COLOR, $BackSide/B_EdgeColor, $BackSide/A_EdgeColor.LAST_STICKER_COLOR, $BackSide/C_EdgeColor, $BackSide/B_EdgeColor.LAST_STICKER_COLOR, $BackSide/D_EdgeColor, $BackSide/C_EdgeColor.LAST_STICKER_COLOR)
	

# Turn the top face counter clockwise.
func U_CCW():
	# Rearrange the stickers to update piece positions.
	pass
	
# Turn the top face 180 degrees.
func U2():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the bottom face clockwise.
func D():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the bottom face counter clockwise.
func D_CCW():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the bottom face 180 degrees.
func D2():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the front face clockwise.
func F():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the front face counter clockwise.
func F_CCW():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the front face 180 degrees.
func F2():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the back face clockwise.
func B():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the back face counter clockwise.
func B_CCW():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the back face 180 degrees.
func B2():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the right face clockwise.
func R():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the right face counter clockwise.
func R_CCW():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the right face 180 degrees.
func R2():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the left face clockwise.
func L():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the left face counter clockwise.
func L_CCW():
	# Rearrange the stickers to update piece positions.
	pass

# Turn the left face 180 degrees.
func L2():
	# Rearrange the stickers to update piece positions.
	pass


# Rotate the entire cube clockwise along the x axis.
func X():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube counter clockwise along the X axis.
func X_CCW():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube 180 degrees along the x axis.
func X2():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube clockwise along the y axis.
func Y():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube counter clockwise along the y axis.
func Y_CCW():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube 180 degrees along the y axis.
func Y2():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube clockwise along the z axis.
func Z():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube counter clockwise along the z axis.
func Z_CCW():
	# Rearrange the stickers to update piece positions.
	pass
	
# Rotate the entire cube 180 degrees along the z axis.
func Z2():
	# Rearrange the stickers to update piece positions.
	pass
