class_name MainMenu
extends Control

signal new_game_pressed
signal exit_game_pressed


func _on_new_game_btn_pressed() -> void:
	SigBus.NewGamePressed.emit()


func _on_exit_btn_pressed() -> void:
	SigBus.ExitGamePressed.emit()
