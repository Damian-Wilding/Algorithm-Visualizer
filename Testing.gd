extends Node3D

var piece
var iterator = 0.0
var rotation_speed = 2
var location
var time_to_turn = 3
var place_to_rotate_to = PI
# Called when the node enters the scene tree for the first time.
func _ready():
	piece = $Node3D/Area3D/MeshInstance3D
	#var iterator = 0
	#piece.rotation = Vector3(3,2,3)
	#print(piece.position)
	location = piece.rotation.x 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		U()
	
	elif Input.is_action_just_released("ui_text_caret_down"):
		U2()
	
	if iterator < time_to_turn:
		piece.rotation.x = lerp_angle(piece.rotation.x, place_to_rotate_to, delta)
		print(iterator)
		iterator += delta


func _on_tester_timer_timeout():
	#$Node3D/Area3D/MeshInstance3D.position = Vector3(1,2,3)ss
	print($Node3D/Area3D/MeshInstance3D.rotation.x)
	
	
	
# This code below is from the cube script. I put it here in case I ever need it.
func U():
	if iterator >= time_to_turn:
		iterator = 0.0
		place_to_rotate_to += PI / 2
		
func U2():
	if iterator >= time_to_turn:
		iterator = 0.0
		place_to_rotate_to += PI
# Have the cube continue to rotate if the timer is running.
	#if $HowLongToTurn90Degrees.is_stopped() == false:
		# Iterate through all the pieces that need to be turned.
		#for piece in CURRENTLY_MOVING_PIECES:
			# Rotate the pieces based on the axis rotational velocities.
			#piece.rotation.y = lerp_angle(piece.rotation.y, deg_to_rad(DEGREES_TO_ROTATE), delta * deg_to_rad(DEGREES_TO_ROTATE) * TURN_SPEED)
