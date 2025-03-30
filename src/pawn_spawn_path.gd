class_name PawnSpawnPath extends Path2D

@export var camera_path : NodePath

func _ready():
	var camera : Camera2D = get_node_or_null(camera_path)
	if camera:
		create_path_around_camera(camera)
	else:
		print("ERROR: Couldn't establish camera bounds for pawn spawning!")

func create_path_around_camera(camera: Camera2D):
	var viewport_size = get_viewport().size
	var half_size = viewport_size / 2.0

	# center of camera is at its global position
	var cam_center = camera.global_position
	
	var top_left = Vector2(0, 0)
	var top_right = Vector2(2*cam_center.x, 0.0)
	var bottom_right = 2*cam_center
	var bottom_left = Vector2(0.0, 2*cam_center.y)

	var curve = Curve2D.new()
	curve.add_point(top_left)
	curve.add_point(top_right)
	curve.add_point(bottom_right)
	curve.add_point(bottom_left)
	curve.add_point(top_left)  # adding first point closes curve

	self.curve = curve
