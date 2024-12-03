extends Control

# This variable is just a dictionary that has the names of buttons as its keys and the corresponding cube controller as their value.
var BUTTONS_TO_CUBE_CONTROLLER_CONNECTION_DICTIONARY = {"F2LButton": "CubeControllerF2L", "OLLButton1": "CubeControllerOLL1", "OLLButton2": "CubeControllerOLL2", "PLLButton1": "CubeControllerPLL1", "PLLButton2": "CubeControllerPLL2"}
# This dictionary has the names of buttons as its keys and the corresponding scenes that they open as their value.
var BUTTONS_TO_SCENES_DICTIONARY = {"F2LButton": "res://Scenes/Tutorial_Screens/f2l_tutorial_scene.tscn", "OLLButton1": "res://Scripts/Tutorial_Screens/OLL1TutorialScene.gd", "OLLButton2": "res://Scripts/Tutorial_Screens/OLL2TutorialScene.gd", "PLLButton1": "res://Scripts/Tutorial_Screens/PLL1TutorialScene.gd", "PLLButton2": "res://Scripts/Tutorial_Screens/PLL2TutorialScene.gd"}

# Called when the node enters the scene tree for the first time.
func _ready():
	# Give all the cube controllers algorithms to do when active.
	get_parent().get_parent().find_child("CubeControllerF2L").ALGORITHM = ["d", "d", "d", "d"]
	get_parent().get_parent().find_child("CubeControllerOLL1").ALGORITHM = ["U", "U", "U", "U"]
	get_parent().get_parent().find_child("CubeControllerOLL2").ALGORITHM = ["U", "U", "U", "U"]
	get_parent().get_parent().find_child("CubeControllerPLL1").ALGORITHM = ["U", "U", "U", "U"]
	get_parent().get_parent().find_child("CubeControllerPLL2").ALGORITHM = ["U", "U", "U", "U"]
	# Go through all of the selected button texts and make them invisible since all the buttons are currently visible.
	for button in $SelectedButtonTexts.get_children():
		button.modulate = Color(1, 1, 1, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# This function runs when the quit button is pressed. It just closes the program.
func _on_quit_button_pressed():
	get_tree().quit()


# This function will take the given button node and activate it. (Activate justs means that the button is the one in focus and the cube under it is rotating/turning.)
func activate_button(button):
	# Go through BUTTONS_TO_CUBE_CONTROLLER_CCONNECTION_DICTIONARY and activate the cube controller value that corresponds to the given button key.
	get_parent().get_parent().find_child(BUTTONS_TO_CUBE_CONTROLLER_CONNECTION_DICTIONARY[button.name]).CONNECTED_CUBE.activate()
	# Start the cube controller's simulation.
	get_parent().get_parent().find_child(BUTTONS_TO_CUBE_CONTROLLER_CONNECTION_DICTIONARY[button.name]).start_simulation()
	# Now Make the button invisible so that the cube is more visible.
	button.modulate = Color(1, 1, 1, 0)
	# Finally, make the corresponding selected button text (This text is the same as the button text. It's just there since the text in the button disappeared on the line above.) appear. 
	$SelectedButtonTexts.find_child(button.name). modulate = Color(1, 1, 1, 1)

# The following 5 functions are just activating the buttons given and their corresponding cubes by using the above function.

# Activate the F2L button.
func _on_f2l_button_active():
	# Call activate_button on the f2l button node.
	activate_button($MenuContainer/Steps/F2LButton)
	
# Activate the OLL1 button.
func _on_oll_button1_active():
	# Call activate_button on the oll1 button node.
	activate_button($MenuContainer/Steps/OLLButton1)
	
# Activate the OLL2 button.
func _on_oll_button2_active():
	# Call activate_button on the oll2 button node.
	activate_button($MenuContainer/Steps/OLLButton2)
	
# Activate the PLL1 button.
func _on_pll_button1_active():
	# Call activate_button on the pll1 button node.
	activate_button($MenuContainer/Steps/PLLButton1)
	
# Activate the PLL2 button.
func _on_pll_button2_active():
	# Call activate_button on the pll2 button node.
	activate_button($MenuContainer/Steps/PLLButton2)
	

# This function will take the given button node and deactivate it. (Deactivate justs means that the button is no longer in focus and the cube under it is no longer rotating/turning.)
func deactivate_button(button):
	# Go through BUTTONS_TO_CUBE_CONTROLLER_CCONNECTION_DICTIONARY and deactivate the cube controller value that corresponds to the given button key.
	get_parent().get_parent().find_child(BUTTONS_TO_CUBE_CONTROLLER_CONNECTION_DICTIONARY[button.name]).CONNECTED_CUBE.IS_CUBE_ACTIVE = false
	# Stop the cube controller's simulation.
	get_parent().get_parent().find_child(BUTTONS_TO_CUBE_CONTROLLER_CONNECTION_DICTIONARY[button.name]).stop_simulation()
	# Now Make the button visible again so that the cube is less visible.
	button.modulate = Color(1, 1, 1, 1)
	# Finally, make the corresponding selected button text (This text is the same as the button text. It's just there since the text in the button appeared on the line above.) disappear. 
	$SelectedButtonTexts.find_child(button.name). modulate = Color(1, 1, 1, 0)

# The following 5 functions are just deactivating the buttons given and their corresponding cubes by using the above function.

# Deactivate the F2L button.
func _on_f2l_button_inactive():
	# Call deactivate_button on the f2l button node.
	deactivate_button($MenuContainer/Steps/F2LButton)
	
# Deactivate the OLL1 button.
func _on_oll_button1_inactive():
	# Call deactivate_button on the oll1 button node.
	deactivate_button($MenuContainer/Steps/OLLButton1)

# Deactivate the OLL2 button.
func _on_oll_button2_inactive():
	# Call deactivate_button on the oll2 button node.
	deactivate_button($MenuContainer/Steps/OLLButton2)

# Deactivate the PLL1 button.
func _on_pll_button1_inactive():
	# Call deactivate_button on the pll1 button node.
	deactivate_button($MenuContainer/Steps/PLLButton1)

# Deactivate the PLL2 button.
func _on_pll_button2_inactive():
	# Call deactivate_button on the pll2 button node.
	deactivate_button($MenuContainer/Steps/PLLButton2)


# This function will activate when one of the 5 scene buttons is pressed. It will open the corresponding scene.
func _on_scene_button_pressed(scene_path):
	# Open the scene using the provided scene_path.
	get_tree().change_scene_to_file(scene_path)
