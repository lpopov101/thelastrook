class_name JohnTest
extends Node2D

const TEST_SCENE = preload("res://scenes/test_scene_john.tscn")
const PAWN_SCENE : PackedScene = preload("uid://mmkclxn06vhw") # pawn.tscn

@onready var pawn_spawn_timer: Timer = $PawnSpawnTimer

enum EnemyTypes{
	PAWN,
	BISHOP
}

func _ready():
	pawn_spawn_timer.timeout.connect(_on_pawn_spawn_timer_timeout)
	pawn_spawn_timer.start()

func _on_pawn_spawn_timer_timeout():	
	var spawn_location : PathFollow2D = get_node_or_null("PawnSpawnPath/PawnSpawnLocation")
	
	if not spawn_location:
		print("Error! Pawn spawn location couldn't be gotten!")
		return
	
	# we can change this later to see if we want to spawn pawns away from the king
	spawn_location.progress_ratio = randf()
	
	#choose who to spawn
	var spawn_type = EnemyTypes.values().pick_random()
	
	#create the correct enemy
	match spawn_type:
		EnemyTypes.PAWN:
			_spawn_pawn_at_position(spawn_location)
		EnemyTypes.BISHOP:
			_spawn_bishop_at_position(spawn_location)
			
	
	#increase timer if wave has increased
	if Global.game_manager.wave > 1:
		pawn_spawn_timer.wait_time = 4
	elif Global.game_manager.wave > 2:
		pawn_spawn_timer.wait_time = 4
	elif Global.game_manager.wave > 4:
		pawn_spawn_timer.wait_time = 2
	elif Global.game_manager.wave > 6:
		pawn_spawn_timer.wait_time = 1

func _spawn_pawn_at_position(spawn_location: PathFollow2D):
	var pawn : Pawn = PAWN_SCENE.instantiate()
	pawn.position = spawn_location.position

	# set pawn's direction perpendicular to the path direction.
	var rotation_inwards = spawn_location.rotation + PI / 2
	pawn.set_velocity_with_rotation(rotation_inwards)

	# spawn the pawn
	add_child(pawn)
	
func _spawn_bishop_at_position(pawn_spawn_location) -> void:
	#create bishop
	var new_bishop = Bishop.new_bishop()
	
	#set bishop position
	new_bishop.position = pawn_spawn_location.position
	
	#add to tree
	add_child(new_bishop)

static func new_scene() -> JohnTest:
	var new_s = TEST_SCENE.instantiate()
	return new_s
