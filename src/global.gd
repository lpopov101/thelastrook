extends Node

var game_manager: GameManager
var input_manager: InputManager
var audio_manager: AudioManager

const ENEMY_GROUP = "enemy"
const ENEMY_ATTACK_GROUP = "enemyAttack"
const PLAYER_ATTACK_GROUP = "playerAttack"

func _ready() -> void:
	input_manager = InputManager.new()
	add_child(input_manager)
	audio_manager = AudioManager.new()
	add_child(audio_manager)
