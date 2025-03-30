class_name InputManager extends Node

@export var up_action = "up"
@export var down_action = "down"
@export var left_action = "left"
@export var right_action = "right"
@export var boost_action = "boost"
@export var brake_action = "brake"
@export var ability_action = "ability"
@export var change_ability_moat_action = "change_ability_moat"
@export var change_ability_cannon_action = "change_ability_cannon"
@export var change_ability_castle_action = "change_ability_castle"

func get_move_dir() -> Vector2:
	var move_dir = Vector2.ZERO
	if Input.is_action_pressed(up_action):
		move_dir.y -= 1
	if Input.is_action_pressed(down_action):
		move_dir.y += 1
	if Input.is_action_pressed(left_action):
		move_dir.x -= 1
	if Input.is_action_pressed(right_action):
		move_dir.x += 1
	return move_dir

func get_boost() -> bool:
	return Input.is_action_pressed(boost_action)

func get_brake() -> bool:
	return Input.is_action_pressed(brake_action)

func get_ability() -> bool:
	return Input.is_action_just_pressed(ability_action)

func get_change_ability_moat() -> bool:
	return Input.is_action_just_pressed(change_ability_moat_action)

func get_change_ability_cannon() -> bool:
	return Input.is_action_just_pressed(change_ability_cannon_action)

func get_change_ability_castle() -> bool:
	return Input.is_action_just_pressed(change_ability_castle_action)

func get_just_pressed_move_dir() -> Vector2:
	var move_dir = Vector2.ZERO
	if Input.is_action_just_pressed(up_action):
		move_dir.y -= 1
	if Input.is_action_just_pressed(down_action):
		move_dir.y += 1
	if Input.is_action_just_pressed(left_action):
		move_dir.x -= 1
	if Input.is_action_just_pressed(right_action):
		move_dir.x += 1
	return move_dir
