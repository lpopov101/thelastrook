class_name MainMenu
extends Control

signal new_game_pressed
signal exit_game_pressed


func _on_new_game_btn_pressed() -> void:
	new_game_pressed.emit()


func _on_exit_btn_pressed() -> void:
	exit_game_pressed.emit()
