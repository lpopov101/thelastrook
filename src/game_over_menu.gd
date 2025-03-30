class_name GameOverMenu
extends Control

const GAME_OVER_MENU = preload("res://scenes/game_over_menu.tscn")

static func new_scene() -> GameOverMenu:
	return GAME_OVER_MENU.instantiate()


func _on_new_game_btn_pressed() -> void:
	SigBus.NewGamePressed.emit()


func _on_exit_to_main_btn_pressed() -> void:
	SigBus.MainMenuPressed.emit()
