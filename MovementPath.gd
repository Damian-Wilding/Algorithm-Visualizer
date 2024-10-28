extends Path3D

# This is the radius of the path.
var RADIUS = 3
# How many points are going to be on the circular path. (The more there are, the smoother it will move.)
var POINTS_IN_CIRCLE = 360

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create a curve that will be the path.
	var rotation_curve = Curve3D.new()
	# Draw a point for the path in a circle. iterate through each number in the number of points chosen from 1-POINTS_IN_CIRCLE.
	for number in range(POINTS_IN_CIRCLE):
		var angle = TAU * number / POINTS_IN_CIRCLE # TAU is a built in constant that is 2 * PI
		# Get the X and Y value of the point by finding the SIN and COS of the angle calculated above.
		var x = RADIUS * cos(angle)
		var y = RADIUS * sin(angle)
		# Add the point to the curve that is being made.
		rotation_curve.add_point(Vector3(x, y, 0))
	# Add the last point to the curve. It should be the same as the first point.
	rotation_curve.add_point(rotation_curve.get_point_position(0))
	# Make the rotation_curve this Nodes curve.
	curve = rotation_curve
	print(curve)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # $PathFollow3D.progress += delta * 10
