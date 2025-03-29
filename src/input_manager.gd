class_name InputManager extends Node

@export var up_action = "up"
@export var down_action = "down"   
@export var left_action = "left"
@export var right_action = "right"

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
