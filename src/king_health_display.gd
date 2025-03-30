extends CanvasLayer

@onready var progress_bar: ProgressBar = $HBoxContainer/ProgressBar
@onready var wave: Label = $HBoxContainer/Wave
		
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	progress_bar.value = Global.game_manager.king_health
	wave.text = "Wave: " + str(Global.game_manager.wave)
