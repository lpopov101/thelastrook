class_name Rook extends CharacterBody2D

@export var speed = 300

var cur_move_dir = Vector2.ZERO

func _physics_process(_delta: float):
	var input_move_dir = Global.input_manager.get_just_pressed_move_dir()
	update_move_dir(input_move_dir)
	process_collisions()
	velocity = cur_move_dir * speed
	move_and_slide()

func update_move_dir(input_move_dir: Vector2):
	if not is_zero_approx(input_move_dir.y):
		cur_move_dir = Vector2(0, input_move_dir.y)
	elif not is_zero_approx(input_move_dir.x):
		cur_move_dir = Vector2(input_move_dir.x, 0)

func process_collisions():
	var collision_idx = 0
	while get_slide_collision_count() > 0 and collision_idx < get_slide_collision_count():
		var collision = get_slide_collision(collision_idx)
		if collision != null:
			var collider = collision.get_collider()
			if collider is KingCharacter:
				print("hi")
				cur_move_dir *= -1.0
		collision_idx += 1
