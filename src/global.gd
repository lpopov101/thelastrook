extends Node

var game_manager: GameManager
var input_manager: InputManager

const ENEMY_GROUP = "enemy"
const ENEMY_ATTACK_GROUP = "enemyAttack"
const PLAYER_ATTACK_GROUP = "playerAttack"

func _ready() -> void:
	input_manager = InputManager.new()
	add_child(input_manager)
