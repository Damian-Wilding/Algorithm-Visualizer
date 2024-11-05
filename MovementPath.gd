extends Path3D
@export var follower = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	# Remove all children from the path. (This should just remove the PathFollow3D that is instantiated with this path.
	##empty_path()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This removes all child nodes from the path.
func empty_path():
	# Go through all children and remove them.
	for node in get_children():
		remove_child(node)


# This will reset the progress of the PathFollow3D child(ren) of this path.
func reset_path():
	# Go through all children of the path and reset their progress to 0.
	for follower in get_children():
		follower.progress = 0


# Create a new PathFollow3D child for this movement path and adds the provided piece to it as a child.
func add_path_follower(piece, given_progress):
	# Create a new path follower node to use as the parent to the piece. 
	var follower = PathFollow3D.new()
	follower.name = piece.name
	# Then add its progress which has also been provided as an arguement.
	follower.progress = given_progress
	# Remove the piece from its parent if it has one.
	piece.get_parent().remove_child(piece)
	# Add the piece as a child to the new path follower. Then add that path follower as a child to the movement path instance that is calling this function. (self)	
	follower.add_child(piece)
	add_child(follower)
