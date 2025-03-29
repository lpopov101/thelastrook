class_name GameManager
extends Node

@export_group("Scene")
@export var world_2d : Node2D
@export var gui : Control

@export_group("Wave")
@export var wave : int = 0

var curr_2d_scene
var curr_gui_scene

func _ready() -> void:
	Global.game_manager = self
	
	curr_gui_scene = $GUI/MainMenu
	
func new_game() -> void:
	print("new game")
	
func open_settings() -> void:
	print("settings")
	
func exit_game() -> void:
	print("exit")
	get_tree().quit()

	
## Changes the GUI scene.
##
## If delete is set to true, the current scene will be removed entirely.
## If keep_running is set to true, the current scene will be set to invisible.
## Else the current scene will be removed from the tree but remain in memory.
func change_gui_scene(new_scene: Node, delete: bool = true, keep_running: bool = false) -> void:
	if curr_gui_scene != null:
		if delete:
			curr_gui_scene.queue_free() #Removes node entirely
		elif keep_running:
			curr_gui_scene.visible = false #keeps in memory and running
		else:
			gui.remove_child(curr_gui_scene)
	
	if new_scene != null:
		gui.add_child(new_scene)
		
	curr_gui_scene = new_scene

## Changes the 2d scene.
##
## If delete is set to true, the current scene will be removed entirely.
## If keep_running is set to true, the current scene will be set to invisible.
## Else the current scene will be removed from the tree but remain in memory.
func change_2d_scene(new_scene: Node, delete: bool = true, keep_running: bool = false) -> void:
	if curr_2d_scene != null:
		if delete:
			curr_2d_scene.queue_free() #Removes node entirely
		elif keep_running:
			curr_2d_scene.visible = false #keeps in memory and running
		else:
			world_2d.remove_child(curr_2d_scene)
		
	world_2d.add_child(new_scene)
	curr_2d_scene = new_scene
