class_name powerup_spawner extends Node

@onready var powerup_moat_scene: PackedScene = preload("res://scenes/powerup_moat.tscn")
@onready var powerup_cannon_scene: PackedScene = preload("res://scenes/powerup_cannon.tscn")
@onready var powerup_castle_scene: PackedScene = preload("res://scenes/powerup_castle.tscn")
@onready var rook: Rook = $"../Rook"

@onready var spawn_sound: AudioStream = preload("res://assets/powerup_spawn.ogg")

@export var min_x = 50
@export var min_y = 50
@export var max_x = 1230
@export var max_y = 670
@export var try_spawn_interval_ms = 2000
@export var time_before_spawn_possible_ms = 4000
@export var powerup_time_to_live_ms = 2500
@export var spawn_probability = 0.1
@export var min_spawn_dist_to_rook = 350

var last_spawn_time_ms: int = 0

func _ready() -> void:
    last_spawn_time_ms = Time.get_ticks_msec() + time_before_spawn_possible_ms - try_spawn_interval_ms
    randomize()

func _process(_delta: float) -> void:
    if Time.get_ticks_msec() - last_spawn_time_ms > try_spawn_interval_ms:
        if randf() < spawn_probability:
            spawn_powerup()
        last_spawn_time_ms = Time.get_ticks_msec()

func spawn_powerup() -> void:
    var powerup_scene: PackedScene = null
    var powerup_rand = randf()
    if powerup_rand < 0.33:
        powerup_scene = powerup_moat_scene
    elif powerup_rand < 0.66:
        powerup_scene = powerup_cannon_scene
    else:
        powerup_scene = powerup_castle_scene
    var powerup: AbilityPowerup = powerup_scene.instantiate()
    powerup.spawn_time_ms = Time.get_ticks_msec()
    powerup.time_to_live_ms = powerup_time_to_live_ms
    powerup.global_position = Vector2(
        randi_range(min_x, max_x),
        randi_range(min_y, max_y)
    )
    while powerup.global_position.distance_to(rook.global_position) < min_spawn_dist_to_rook:
        powerup.global_position = Vector2(
            randi_range(min_x, max_x),
            randi_range(min_y, max_y)
        )
    get_parent().add_child(powerup)
    Global.audio_manager.play_sound(spawn_sound, false, 8)