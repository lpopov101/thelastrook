class_name AbilityPowerup extends Area2D

@export var ability: GameManager.Ability = GameManager.Ability.MOAT
@export var time_to_live_ms = 5000

var spawn_time_ms: int = 0
var sprites: Array

func _process(_delta: float) -> void:
	if Time.get_ticks_msec() - spawn_time_ms > time_to_live_ms:
		queue_free()
	else:
		for sprite in sprites:
			sprite.modulate.a = 1.0 - float(Time.get_ticks_msec() - spawn_time_ms) / float(time_to_live_ms)
	
func _ready() -> void:
	for child in get_children():
		if child is Sprite2D:
			sprites.append(child)

func _init() -> void:
	spawn_time_ms = Time.get_ticks_msec()
	body_entered.connect(on_body_entered)

func on_body_entered(_body: Node) -> void:
	if _body is Rook:
		Global.game_manager.cur_ability = ability
		queue_free()
