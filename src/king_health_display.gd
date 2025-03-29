extends CanvasLayer

@onready var progress_bar: ProgressBar = $HBoxContainer/ProgressBar
@onready var wave: Label = $HBoxContainer/Wave

signal KingDeath

@export var curr_health : float = 100:
	set(new_health):
		curr_health = clamp(curr_health, 0, 100)
		
		if progress_bar != null:
			progress_bar.value = curr_health
			
		if curr_health == 0:
			KingDeath.emit()

@export var curr_wave : int = 1:
	set(new_wave):
		curr_wave = new_wave
