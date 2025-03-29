class_name Rook extends CharacterBody2D

@export var speed = 10000

var cur_move_dir = Vector2.ZERO

func _physics_process(delta: float):
	var input_move_dir = Global.input_manager.get_move_dir()
	update_move_dir(input_move_dir)
	velocity = cur_move_dir * speed * delta
	move_and_slide()
	if get_slide_collision_count() == 0:
		return
	for collision_idx in [0, get_slide_collision_count() - 1]:
		var collision = get_slide_collision(collision_idx)
		if collision != null:
			var collider = collision.get_collider()
			if collider is KingCharacter:
				collider.take_damage(1)

func update_move_dir(input_move_dir: Vector2):
	if not is_zero_approx(input_move_dir.y):
		cur_move_dir = Vector2(0, input_move_dir.y)
	elif not is_zero_approx(input_move_dir.x):
		cur_move_dir = Vector2(input_move_dir.x, 0)
