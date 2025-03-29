extends Node

var game_manager : GameManager
var input_manager: InputManager

func _ready() -> void:
	input_manager = InputManager.new()
	add_child(input_manager)
