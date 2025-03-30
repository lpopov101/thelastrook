class_name Queen
extends CharacterBody2D

const QUEEN = preload("res://scenes/queen.tscn")
@export var speed : float = 500.0 # default
@export var straight_line_movement_probability : float = 0.5 # default

var target : Vector2 = Vector2.ZERO
var y_direction : int = -1
var x_direction : int = 1

@onready var hitbox = $Hitbox

static func new_queen() -> Queen:
	return QUEEN.instantiate()
	
func _ready() -> void:
	SigBus.KingPosition.connect(_update_target)
	hitbox.body_entered.connect(_on_hitbox_body_entered)
	hitbox.area_entered.connect(_on_hitbox_area_entered)
	
	_update_target(Vector2(640, 360))

func _physics_process(_delta: float) -> void:
	velocity = Vector2(x_direction, y_direction)

	if not velocity.is_normalized():
		velocity = velocity.normalized()

	velocity *= speed
	
	move_and_slide()
		

func _update_target(pos : Vector2) -> void:
	target = pos

	var y_dist = abs(target.y - position.y)
	var x_dist = abs(target.x - position.x)

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
	
	# random chance of queen moving vertically/horizontally
	if (randf() >= straight_line_movement_probability):
		# target is further away in y distance than x
		if y_dist > x_dist:
			x_direction = 0
		elif x_dist > y_dist:
			y_direction = 0
		# Don't do anything if equal
	
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group(Global.PLAYER_ATTACK_GROUP):
		queue_free()
		

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group(Global.PLAYER_ATTACK_GROUP):
		queue_free()
		
