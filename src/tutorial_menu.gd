class_name TutorialMenu
extends Control

const TUTORIAL_MENU = preload("res://scenes/tutorial_menu.tscn")

static func new_tutorial() -> TutorialMenu:
	return TUTORIAL_MENU.instantiate()


func _on_cancel_pressed() -> void:
	SigBus.CloseTutorial.emit()


func _on_play_pressed() -> void:
	SigBus.NewGamePressed.emit()
