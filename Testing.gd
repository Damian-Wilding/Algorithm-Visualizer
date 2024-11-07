extends Node3D

var piece
var piece2
var piece3
var iterator = 10.0
#var rotation_speed = 2
var location
var time_to_turn = .1
var place_to_rotate_to = 0
var place_to_rotate_to2 = 0
var place_to_rotate_to3 = - PI / 2
var speed_multiplier = 10
var a_dictionary = {"ItalianCorner": {"X": 1, "Y": 2, "Z": 0}, "IrishCorner": {"X": 4, "Y": 5, "Z": 6}}

# Called when the node enters the scene tree for the first time.
func _ready():
	piece = $Cube/WhiteCenter
	piece2 = $Cube/WG
	piece3 = $Cube/ItalianCorner
	$Cube.remove_child(piece)
	$Cube.remove_child(piece2)
	$Cube.remove_child(piece3)
	print(piece.name)
	##remove_child($Cubie2)
	#remove_child(piece)
	#$MovementPath/follower.add_child(piece)   #.add_child(piece) 
	#print($MovementPath/follower.name)
	#piece = $Path3D/PathFollow3D/Cubie
	
	$Cube/TurningSide.add_child(piece)
	$Cube/TurningSide.add_child(piece2)
	$Cube/TurningSide.add_child(piece3)
	#piece2 = $Cubie2
	
	#$MovementPath/PathFollow3D.add_child(piece2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#piece2.get_parent().progress += delta * speed_multiplier
	#wrapf(piece2.get_parent().progress, 0, 1)
	#piece.get_parent().progress += delta * speed_multiplier
	#print("Progress: %0.2f" % $MovementPath/follower.progress_ratio)
	#print(piece.global_position)
	if $TesterTimer.is_stopped() != true:
		
		$Cube/TurningSide.rotation.y += .01
		#piece.transform = piece.transform.rotated(Vector3(0,3,0), -1 * piece.global_rotation.y + 20)
		#piece.rotate_object_local(Vector3(1, 0, 0), 0.01)
		#$MovementPath/follower.progress_ratio = $MovementPath/follower.progress_ratio + delta * time_to_turn
		#print($MovementPath/follower.get_child(0).global_position)
	#if Input.is_action_just_released("ui_text_caret_down"):
	#	if piece.get_parent().get_parent().name == "Path3D2":
	#		piece.get_parent().remove_child(piece)
	#		$Path3D/PathFollow3D.add_child(piece)
	#		piece = $Path3D/PathFollow3D/Cubie
	#	elif piece.get_parent().get_parent().name == "Path3D":
	#		piece.get_parent().remove_child(piece)
	#		$Path3D2/PathFollow3D.add_child(piece)
	#		piece = $Path3D2/PathFollow3D/Cubie
	else:
		$Cube/TurningSide.rotation.x += 0.01		
	#print(piece2.get_parent().progress_ratio)
	#
	


func _on_tester_timer_timeout():
	#$Node3D/Area3D/MeshInstance3D.position = Vector3(1,2,3)ss
	#print(piece.rotation.x)
	pass
	
	
	
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
