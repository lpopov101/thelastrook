class_name Rook extends CharacterBody2D

@export var speed = 10000

var cur_move_dir = Vector2.ZERO

func _physics_process(delta: float):
	var input_move_dir = Global.input_manager.get_move_dir()
	update_move_dir(input_move_dir)
	velocity = cur_move_dir * speed * delta
	move_and_slide()
	var collision = get_last_slide_collision()
	if collision != null:
		var collider = collision.get_collider()
		if collider is KingCharacter:
			print("hit king")

func update_move_dir(input_move_dir: Vector2):
	if not is_zero_approx(input_move_dir.y):
		cur_move_dir = Vector2(0, input_move_dir.y)
	elif not is_zero_approx(input_move_dir.x):
		cur_move_dir = Vector2(input_move_dir.x, 0)
