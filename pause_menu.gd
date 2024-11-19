extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This function runs when the resume menu button has been pressed. It just closes the menu.
func _on_resume_button_pressed():
	queue_free()
	

# This function runs when the quit button is pressed. It just closes the program.
func _on_quit_button_pressed():
	get_tree().quit()


# This function runs when the home button is pressed.
func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
