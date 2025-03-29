class_name MainMenu
extends Control

signal new_game_pressed
signal settings_pressed
signal exit_game_pressed


func _on_new_game_btn_pressed() -> void:
	Global.game_manager.new_game()
	new_game_pressed.emit
	

func _on_settings_btn_pressed() -> void:
	Global.game_manager.open_settings()
	settings_pressed.emit


func _on_exit_btn_pressed() -> void:
	Global.game_manager.exit_game()
	exit_game_pressed.emit
