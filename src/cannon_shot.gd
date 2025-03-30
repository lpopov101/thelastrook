class_name CannonShot extends Area2D

@onready var hit_sound: AudioStream = preload("res://assets/enemydefeateddeep.ogg")

var speed = 100
var direction: Vector2 = Vector2.ZERO

func _init() -> void:
	body_entered.connect(on_body_entered)
	area_entered.connect(on_area_entered)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func on_body_entered(body: Node) -> void:
	if body.is_in_group(Global.ENEMY_GROUP):
		Global.audio_manager.play_sound(hit_sound, false, 2)
		queue_free()

func on_area_entered(area: Area2D) -> void:
	if area.is_in_group(Global.ENEMY_GROUP):
		Global.audio_manager.play_sound(hit_sound, false, 2)
	queue_free()
