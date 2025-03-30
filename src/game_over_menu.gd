class_name GameOverMenu
extends Control

const GAME_OVER_MENU = preload("res://scenes/game_over_menu.tscn")

@onready var wave_label: Label = $PanelContainer/VBoxContainer/WaveLabel

static func new_scene() -> GameOverMenu:
	return GAME_OVER_MENU.instantiate()
	

func _ready() -> void:
	wave_label.text = "Wave: " + str(Global.game_manager.wave)


func _on_new_game_btn_pressed() -> void:
	SigBus.NewGamePressed.emit()


func _on_exit_to_main_btn_pressed() -> void:
	SigBus.MainMenuPressed.emit()
