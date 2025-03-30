class_name WaveTimer
extends Timer

const WAVE_TIMER = preload("res://scenes/wave_timer.tscn")
@export var starting_wait_time : int = 25

static func new_scene() -> WaveTimer:
	return WAVE_TIMER.instantiate()
	
func _ready() -> void:
	wait_time = starting_wait_time
	
func _process(delta: float) -> void:
	if is_stopped():
		wait_time = starting_wait_time + (5 * Global.game_manager.wave)
		SigBus.WaveComplete.emit()
		start()
