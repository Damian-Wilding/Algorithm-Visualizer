extends Node3D

var piece
var iterator = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	piece = $Node3D/Area3D/MeshInstance3D
	var random_place = Vector3(3,3,3)
	#var iterator = 0
	#piece.rotation = Vector3(3,2,3)
	#print(piece.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($Node3D/Area3D/MeshInstance3D.rotation)
	#$Node3D/Area3D/MeshInstance3D.position.lerp(Vector3(50,50,50), 0.01)
	$Node3D/Area3D/MeshInstance3D.rotation.x = lerp_angle($Node3D/Area3D/MeshInstance3D.rotation.x, PI/3, iterator)
	print(delta)
	print(iterator)
	sssssssssssssssssssssssssssssssssssssssssiterator += delta


func _on_tester_timer_timeout():
	#$Node3D/Area3D/MeshInstance3D.position = Vector3(1,2,3)ss
	print($Node3D/Area3D/MeshInstance3D.rotation.x)
	
