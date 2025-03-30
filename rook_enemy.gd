class_name RookEnemy
extends CharacterBody2D

const ROOK_ENEMY = preload("res://scenes/rook_enemy.tscn")
@onready var enemy_defeated_sound: AudioStream = preload("res://assets/enemydefeated.ogg")

@export var speed : float = 100.0 # default

var target : Vector2 = Vector2.ZERO
var y_direction : int = 0
var x_direction : int = 0


static func new_rook() -> Bishop:
	return ROOK_ENEMY.instantiate()
	
func _ready() -> void:
	SigBus.KingPosition.connect(_update_target)
	
	_update_target(Vector2(640, 360))

func _physics_process(_delta: float) -> void:
		
	velocity = Vector2(speed * x_direction, speed * y_direction)
	
	move_and_slide()
		

func _update_target(pos : Vector2) -> void:
	target = pos
	
	var y_dist = abs(target.y - position.y)
	var x_dist = abs(target.x - position.x)
	
	if y_dist > x_dist:
		#target is further in the y direction
		x_direction = 0
	
		#if target is above set y direction to up and vice versa
		if target.y < position.y:
			y_direction = -1
		else:
			y_direction = 1
	else:
		#target is furter in the x direction
		y_direction = 0
	
		#if target is to right set x direction to right and vice versa
		if target.x < position.x:
			x_direction = -1
		else:
			x_direction = 1


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group(Global.PLAYER_ATTACK_GROUP):
		Global.audio_manager.play_sound(enemy_defeated_sound, false, 0)
		queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group(Global.PLAYER_ATTACK_GROUP):
		Global.audio_manager.play_sound(enemy_defeated_sound, false, 0)
		queue_free()
