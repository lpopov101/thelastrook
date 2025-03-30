class_name Bishop
extends CharacterBody2D

const BISHOP = preload("res://scenes/bishop.tscn")
@export var speed : float = 100.0 # default

var target : Vector2 = Vector2.ZERO
var y_direction : int = -1
var x_direction : int = 1


static func new_bishop() -> Bishop:
	return BISHOP.instantiate()
	
func _ready() -> void:
	SigBus.KingPosition.connect(_update_target)
	
	_update_target(Vector2(640, 360))

func _physics_process(_delta: float) -> void:
		
	velocity = Vector2(speed * x_direction, speed * y_direction)
	
	move_and_slide()
		

func _update_target(pos : Vector2) -> void:
	target = pos
	
	#if target is above set y direction to up and vice versa
	if target.y < position.y:
		y_direction = -1
	else:
		y_direction = 1
	
	#if target is to right set x direction to right and vice versa
	if target.x < position.x:
		x_direction = -1
	else:
		x_direction = 1

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group(Global.PLAYER_ATTACK_GROUP):
		queue_free()
		

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group(Global.PLAYER_ATTACK_GROUP):
		queue_free()
		
