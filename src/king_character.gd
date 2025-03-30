class_name KingCharacter extends CharacterBody2D

@export var SPEED = 50
@export var HEALTH = 10
@export var INVINCIBILITY_MS = 100
@export var CHANGE_DIR_MS = 2000
var LAST_DAMAGE_TIME = - INVINCIBILITY_MS
var LAST_CHANGE_DIR_TIME = - CHANGE_DIR_MS

# Other not important stuff
var direction = 0
var pi = 3 * acos(.5)
var dx = 0
var dy = 0
var startX = 0
var startY = 0

@onready var king_character: KingCharacter = $"."

func _ready() -> void:
	startX = self.position.x
	startY = self.position.y
	change_direction()

func _physics_process(_delta: float) -> void:
	var cur_time = Time.get_ticks_msec()
	if cur_time - LAST_CHANGE_DIR_TIME > CHANGE_DIR_MS:
		change_direction()
		LAST_CHANGE_DIR_TIME = cur_time
	velocity = Vector2(dx, dy).normalized() * SPEED
	move_and_slide()

func change_direction() -> void:
	direction = randi() % 8
	dx = cos(direction * (PI / 4))
	dy = sin(direction * (PI / 4)) 

func take_damage(damage: int):
	var cur_time = Time.get_ticks_msec()
	if cur_time - LAST_DAMAGE_TIME > INVINCIBILITY_MS:
		HEALTH -= damage
		print("King took damage: ", damage, " HP left: ", HEALTH)
		LAST_DAMAGE_TIME = cur_time


func _on_king_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group(Global.ENEMY_ATTACK_GROUP):
		SigBus.DamagedKing.emit()


func _on_position_timer_timeout() -> void:
	SigBus.KingPosition.emit(position)
