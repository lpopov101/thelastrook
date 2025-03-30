class_name Pawn extends CharacterBody2D
@onready var enemy_defeated_sound: AudioStream = preload("res://assets/enemydefeated.ogg")

const PAWN = preload("res://scenes/pawn.tscn")
@export var speed : float = 100.0 # default


static func new_pawn() -> Pawn:
	return PAWN.instantiate()

# _init runs on instantiation. _ready runs on node addition to tree :)
func _init():
	velocity = Vector2(speed, 0.0)
	
func _ready():
	$PawnHitbox.body_entered.connect(on_body_entered)
	$PawnHitbox.area_entered.connect(on_area_entered)

func _physics_process(_delta: float):
	move_and_slide()

func set_velocity_with_rotation(rotation: float):
	velocity = velocity.rotated(rotation)

func on_body_entered(body: Node2D):
	if (body.is_in_group(Global.PLAYER_ATTACK_GROUP)):
		Global.audio_manager.play_sound(enemy_defeated_sound, false, 0)
		queue_free()

func on_area_entered(area: Node2D):
	if (area.is_in_group(Global.PLAYER_ATTACK_GROUP)):
		Global.audio_manager.play_sound(enemy_defeated_sound, false, 0)
		queue_free()
