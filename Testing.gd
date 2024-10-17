extends Node3D

var piece
var iterator = 10.0
#var rotation_speed = 2
var location
var time_to_turn = .5
var place_to_rotate_to = 0
var place_to_rotate_to2 = 0
var place_to_rotate_to3 = - PI / 2
# Called when the node enters the scene tree for the first time.
func _ready():
	piece = $Node3D
	#var iterator = 0
	#piece.rotation = Vector3(3,2,3)
	#print(piece.position)
	location = piece.rotation.x 
	print(location)
	piece.position = Vector3(2,2,2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TestCubit.global_rotate(Vector3(0,2,0), PI / 20)
	if Input.is_action_just_released("ui_accept"):
		U()
	
	elif Input.is_action_just_released("ui_text_caret_down"):
		R()
	
	elif Input.is_action_just_released("ui_text_caret_up"):
		F()
	
	if iterator < time_to_turn:
		piece.global_rotation.x = lerp_angle(piece.global_rotation.x, place_to_rotate_to, .1)
		piece.rotation.z = lerp_angle(piece.rotation.z, place_to_rotate_to2, .1)
		piece.rotation.y = lerp_angle(piece.rotation.y, place_to_rotate_to3, .1)
		#print(iterator)
		iterator += delta


func _on_tester_timer_timeout():
	#$Node3D/Area3D/MeshInstance3D.position = Vector3(1,2,3)ss
	print($Node3D.rotation.x)
	
	
	
# This code below is from the cube script. I put it here in case I ever need it.
func U():
	if iterator >= time_to_turn:
		iterator = 0.0
		place_to_rotate_to -= PI / 2
		
func U2():
	if iterator >= time_to_turn:
		iterator = 0.0
		place_to_rotate_to += PI
		
func R():
	if iterator >= time_to_turn:
		iterator = 0.0
		place_to_rotate_to2 += PI / 2
		
func F():
	if iterator >= time_to_turn:
		iterator = 0.0
		place_to_rotate_to3 += PI / 2
# Have the cube continue to rotate if the timer is running.
	#if $HowLongToTurn90Degrees.is_stopped() == false:
		# Iterate through all the pieces that need to be turned.
		#for piece in CURRENTLY_MOVING_PIECES:
			# Rotate the pieces based on the axis rotational velocities.
			#piece.rotation.y = lerp_angle(piece.rotation.y, deg_to_rad(DEGREES_TO_ROTATE), delta * deg_to_rad(DEGREES_TO_ROTATE) * TURN_SPEED)
