class_name Rook extends CharacterBody2D

const CANNON_SHOT_SCENE: PackedScene = preload("uid://8joqcavelbm4") # cannon_shot.tscn

@onready var moat_sprite: Sprite2D = $MoatSprite
@onready var rook_collision_shape: CollisionShape2D = $RookCollisionShape
@onready var moat_collision_shape: CollisionShape2D = $MoatCollisionShape

@export var speed = 300
@export var boost_mult = 1.5
@export var brake_mult = 0.5

@export var moat_cooldown_ms = 5000
@export var moat_duration_ms = 2000
var moat_active = false

@export var cannon_cooldown_ms = 500
@export var cannon_offset = 30

@export var castle_cooldown_ms = 3000

var last_ability_time_ms = -10000
var cur_move_dir = Vector2.ZERO

@onready var king: KingCharacter = $"../King"

func _ready() -> void:
	moat_sprite.visible = false
	moat_collision_shape.disabled = true
	rook_collision_shape.disabled = false

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
	elif Global.game_manager.cur_ability == GameManager.Ability.CASTLE:
		handle_castle()

func handle_moat():
	var cur_time = Time.get_ticks_msec()
	if not moat_active and Global.input_manager.get_ability() and cur_time - last_ability_time_ms > moat_cooldown_ms:
		moat_active = true
		moat_sprite.visible = true
		moat_collision_shape.disabled = false
		rook_collision_shape.disabled = true
		last_ability_time_ms = cur_time
	elif moat_active:
		moat_sprite.self_modulate.a = 1.0 - pow(float(cur_time - last_ability_time_ms) / float(moat_duration_ms), 2)
		if cur_time - last_ability_time_ms > moat_duration_ms:
			moat_active = false
			moat_sprite.visible = false
			moat_collision_shape.disabled = true
			rook_collision_shape.disabled = false

	Global.game_manager.cur_ability_percent = float(cur_time - last_ability_time_ms) / float(moat_cooldown_ms) * 100.0

func handle_cannon():
	var cur_time = Time.get_ticks_msec()
	if Global.input_manager.get_ability() and cur_time - last_ability_time_ms > cannon_cooldown_ms:
		var cannon_shot = CANNON_SHOT_SCENE.instantiate()
		var direction = cur_move_dir if cur_move_dir != Vector2.ZERO else Vector2(1, 0)
		cannon_shot.global_position = global_position + (cannon_offset * direction)
		cannon_shot.speed = speed * 3.0
		cannon_shot.direction = direction
		cannon_shot.rotate(direction.angle())
		get_parent().add_child(cannon_shot)
		last_ability_time_ms = cur_time
	Global.game_manager.cur_ability_percent = float(cur_time - last_ability_time_ms) / float(cannon_cooldown_ms) * 100.0

func handle_castle():
	var cur_time = Time.get_ticks_msec()
	if Global.input_manager.get_ability() and cur_time - last_ability_time_ms > castle_cooldown_ms:
		var temp_king = king.global_position
		var temp_rook = global_position
		global_position = Vector2(-1000, -1000)
		king.global_position = temp_rook
		global_position = temp_king
		last_ability_time_ms = cur_time
	Global.game_manager.cur_ability_percent = float(cur_time - last_ability_time_ms) / float(castle_cooldown_ms) * 100.0
