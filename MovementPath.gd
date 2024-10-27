extends Path3D

# This is the radius of the path.
var RADIUS = 3
# How many points are going to be on the circular path. (The more there are, the smoother it will move.)
var POINTS_IN_CIRCLE = 360

# Called when the node enters the scene tree for the first time.
func _ready():
	# Draw a point for the path in a circle. iterate through each number in the number of points chosen from 1-POINTS_IN_CIRCLE.
	for number in POINTS_IN_CIRCLE:
		var angle = TAU * number / POINTS_IN_CIRCLE # TAU is a built in constant that is 2 * PI
		# Get the X and Y value of the point by finding the SIN and COS of the angle calculated above.
		var x = RADIUS * cos(angle)
		var y = RADIUS * sin(angle)
		# Add the point to the curve that is being made.
		$PathFollow3D.add_point(Vector3(x, 0, y))
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
