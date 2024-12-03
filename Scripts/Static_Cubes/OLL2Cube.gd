extends "res://Scripts/Static_Cubes/cube.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Overwrite the HOME_POSITIONS_AND_ROTATIONS var from cube.gd.
	HOME_POSITIONS_AND_ROTATIONS = {"ItalianCorner": [Vector3(3,3,3), Vector3(0,-PI/2,0)], "IrishCorner": [Vector3(-3,3,3), Vector3(0,-PI/2,0)], "USACorner": [Vector3(3,3,-3), Vector3(0,-PI/2,0)], "NetherlandsCorner": [Vector3(-3,3,-3), Vector3(0,-PI/2,0)], "BobMarleyCorner": [Vector3(3,-3,3), Vector3(-PI,PI/2,PI)], "SpriteCorner": [Vector3(-3,-3,3), Vector3(PI,PI/2,PI)], "PrimaryCorner": [Vector3(3,-3,-3), Vector3(PI,PI/2,PI)], "NerfCorner": [Vector3(-3,-3,-3), Vector3(0,-PI/2,0)], "WG": [Vector3(0,3,3), Vector3(0,-PI/2,0)], "WB": [Vector3(0,3,-3), Vector3(0,-PI/2,0)], "WR": [Vector3(3,3,0), Vector3(0,-PI/2,0)], "WO": [Vector3(-3,3,0), Vector3(0,-PI/2,0)], "GR": [Vector3(3,0,3), Vector3(0,-PI/2,0)], "BR": [Vector3(3,0,-3), Vector3(0,-PI/2,0)], "GO": [Vector3(-3,0,3), Vector3(0,-PI/2,0)], "BO": [Vector3(-3,0,-3), Vector3(0,-PI/2,0)], "YG": [Vector3(0,-3,3), Vector3(0,-PI/2,0)], "YB": [Vector3(0,-3,-3), Vector3(0,-PI/2,0)], "YR": [Vector3(3,-3,0), Vector3(0,-PI/2,0)], "YO": [Vector3(-3,-3,0), Vector3(0,-PI/2,0)], "WhiteCenter": [Vector3(0,3,0), Vector3(0,0,0)], "YellowCenter": [Vector3(0,-3,0), Vector3(-PI,0,PI)], "GreenCenter": [Vector3(0,0,3), Vector3(PI/2,-PI/2,0)], "BlueCenter": [Vector3(0,0,-3), Vector3(-PI/2,-PI/2,0)], "RedCenter": [Vector3(3,0,0), Vector3(0,-PI/2,-PI/2)], "OrangeCenter": [Vector3(-3,0,0), Vector3(0,-PI/2,PI/2)], "Core": [Vector3(0,0,0), Vector3(0,0,0)]}

