class_name GameManager
extends Node

const NEW_GAME_SCENE = preload("res://scenes/test_scene_john.tscn")

@onready var king_hit_sound: AudioStream = preload("res://assets/king_hit.ogg")

@export_group("Scene")
@export var world_2d: Node2D
@export var gui: Control

@export_group("Game State")
@export var wave: int = 0
@export var king_health: int = 0
@export var dmg_amt: int = 20

enum Ability {MOAT, CANNON, CASTLE, NONE}

var ability_name_map = {
	Ability.MOAT: "Moat",
	Ability.CANNON: "Cannon",
	Ability.CASTLE: "Castle"
}

@export var cur_ability = Ability.NONE
var cur_ability_percent = 100.0;

var curr_2d_scene
var curr_gui_scene

func _ready() -> void:
	Global.game_manager = self
	
	curr_gui_scene = $GUI/MainMenu
	
	#connect main menu signals
	_connect_signals()
	
func _input(event: InputEvent) -> void:
	if event.is_action("Escape"):
		if curr_2d_scene != null and curr_gui_scene == null:
			pause_game()

# func _process(_delta: float) -> void:
# 	if Global.input_manager.get_change_ability_cannon():
# 		cur_ability = Ability.CANNON
# 	elif Global.input_manager.get_change_ability_castle():
# 		cur_ability = Ability.CASTLE
# 	elif Global.input_manager.get_change_ability_moat():
# 		cur_ability = Ability.MOAT

## creates a new game and loads the scene
func new_game() -> void:
	print("new game")
	#Pause scenes except for menus
	if get_tree().paused:
		get_tree().paused = false
		
	#reset game info
	wave = 1
	king_health = 100
	cur_ability = Ability.NONE
	
	#create a new game scene
	var new_game_scene = NEW_GAME_SCENE.instantiate()
	
	#add new game to tree
	change_2d_scene(new_game_scene)
	change_gui_scene(null, false, true)

## pauses the game and creates a pause menu and connects the signals for the menu
func pause_game() -> void:
	#curr_2d_scene.get_tree().paused = true
	var new_pause_scene = PauseMenu.new_scene()
	change_gui_scene(new_pause_scene)
	
	get_tree().paused = true

## resumes the game and gets rid of the pause menu
func resume_game() -> void:
	get_tree().paused = false
	change_gui_scene(null)
	
func open_tutorial() -> void:
	change_gui_scene(TutorialMenu.new_tutorial(), false, true)
	
func exit_to_main_menu() -> void:
	get_tree().paused = false
	change_2d_scene(null)
	change_gui_scene($GUI/MainMenu)
	
func exit_game() -> void:
	print("exit")
	get_tree().quit()
	
func king_damaged() -> void:
	king_health = max(king_health - dmg_amt, 0)
	Global.audio_manager.play_sound(king_hit_sound, false, 10)
	if king_health == 0:
		print(Global.game_manager)
		SigBus.GameOver.emit()
		
func update_wave() -> void:
	wave += 1
		
func game_over() -> void:
	print("Game Over")
	change_gui_scene(GameOverMenu.new_scene())
	
	get_tree().paused = true

	
## Changes the GUI scene.
##
## If delete is set to true, the current scene will be removed entirely.
## If keep_running is set to true, the current scene will be set to invisible.
## Else the current scene will be removed from the tree but remain in memory.
func change_gui_scene(new_scene: Node, delete: bool = true, keep_running: bool = false) -> void:
	if curr_gui_scene != null:
		if delete:
			curr_gui_scene.queue_free() # Removes node entirely
		elif keep_running:
			curr_gui_scene.visible = false # keeps in memory and running
		else:
			gui.remove_child(curr_gui_scene)
	
	curr_gui_scene = new_scene
	if curr_gui_scene != null:
		curr_gui_scene.visible = true
		if !gui.get_children().has(curr_gui_scene):
			gui.add_child(new_scene)
		
		
## Changes the 2d scene.
##
## If delete is set to true, the current scene will be removed entirely.
## If keep_running is set to true, the current scene will be set to invisible.
## Else the current scene will be removed from the tree but remain in memory.
func change_2d_scene(new_scene: Node, delete: bool = true, keep_running: bool = false) -> void:
	if curr_2d_scene != null:
		if delete:
			curr_2d_scene.queue_free() # Removes node entirely
		elif keep_running:
			curr_2d_scene.visible = false # keeps in memory and running
		else:
			world_2d.remove_child(curr_2d_scene)
		
	curr_2d_scene = new_scene
	if curr_2d_scene != null:
		curr_2d_scene.visible = true
		if !world_2d.get_children().has(curr_2d_scene):
			world_2d.add_child(new_scene)
			
func _connect_signals() -> void:
	#connect main menu signals
	SigBus.connect("NewGamePressed", new_game)
	SigBus.connect("ExitGamePressed", exit_game)
	SigBus.connect("OpenTutorial", open_tutorial)
	SigBus.connect("CloseTutorial", exit_to_main_menu)
	
	#connect paused menu signals
	SigBus.connect("RestartPressed", new_game)
	SigBus.connect("MainMenuPressed", exit_to_main_menu)
	SigBus.connect("ResumeGamePressed", resume_game)
	
	#connect entity signals
	SigBus.connect("DamagedKing", king_damaged)
	
	#connect game stat signals
	SigBus.connect("GameOver", game_over)
	SigBus.connect("WaveComplete", update_wave)
