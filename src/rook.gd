class_name Rook extends CharacterBody2D

@export var speed = 300
@export var boost_mult = 1.5
@export var brake_mult = 0.5

@export var moat_cooldown_ms = 5000
@export var moat_duration_ms = 2000
var moat_active = false

@export var cannon_cooldown_ms = 500

var last_ability_time_ms = -10000
var cur_move_dir = Vector2.ZERO
var init_scale = scale

func _physics_process(_delta: float):
	handle_abilities()
	handle_movement()

func handle_movement():
	var input_move_dir = Global.input_manager.get_just_pressed_move_dir()
	update_move_dir(input_move_dir)
	process_collisions()
	velocity = cur_move_dir * speed * get_speed_mult()
	move_and_slide()

func update_move_dir(input_move_dir: Vector2):
	if not is_zero_approx(input_move_dir.y):
		cur_move_dir = Vector2(0, input_move_dir.y)
	elif not is_zero_approx(input_move_dir.x):
		cur_move_dir = Vector2(input_move_dir.x, 0)

func get_speed_mult() -> float:
	var speed_mult = 1.0
	if Global.input_manager.get_boost():
		speed_mult *= boost_mult
	elif Global.input_manager.get_brake():
		speed_mult *= brake_mult
	return speed_mult

func process_collisions():
	var collision_idx = 0
	while get_slide_collision_count() > 0 and collision_idx < get_slide_collision_count():
		var collision = get_slide_collision(collision_idx)
		if collision != null:
			var collider = collision.get_collider()
			if collider is KingCharacter:
				cur_move_dir *= -1.0
		collision_idx += 1

func handle_abilities():
	if Global.game_manager.cur_ability == GameManager.Ability.MOAT:
		handle_moat()
	elif Global.game_manager.cur_ability == GameManager.Ability.CANNON:
		handle_cannon()

func handle_moat():
	var cur_time = Time.get_ticks_msec()
	if not moat_active and Global.input_manager.get_ability() and cur_time - last_ability_time_ms > moat_cooldown_ms:
		moat_active = true
		scale = 2 * init_scale
		last_ability_time_ms = cur_time
	elif moat_active and cur_time - last_ability_time_ms > moat_duration_ms:
		moat_active = false
		scale = init_scale

	Global.game_manager.cur_ability_percent = float(cur_time - last_ability_time_ms) / float(moat_cooldown_ms) * 100.0

func handle_cannon():
	var cur_time = Time.get_ticks_msec()
	if Global.input_manager.get_ability() and cur_time - last_ability_time_ms > cannon_cooldown_ms:
		# todo: fire cannon
		last_ability_time_ms = cur_time
	Global.game_manager.cur_ability_percent = float(cur_time - last_ability_time_ms) / float(cannon_cooldown_ms) * 100.0
