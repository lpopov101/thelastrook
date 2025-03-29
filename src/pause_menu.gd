class_name PauseMenu
extends Control

const PAUSE_MENU = preload("res://scenes/pause_menu.tscn")

signal restart_pressed
signal main_menu_pressed
signal resume_game_pressed

static func new_scene() -> PauseMenu:
	return PAUSE_MENU.instantiate()

func _on_restart_btn_pressed() -> void:
	restart_pressed.emit()


func _on_main_menu_btn_pressed() -> void:
	main_menu_pressed.emit()


func _on_resume_btn_pressed() -> void:
	resume_game_pressed.emit()
