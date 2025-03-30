class_name JohnTest
extends Node2D

const TEST_SCENE = preload("res://scenes/test_scene_john.tscn")

@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var king: KingCharacter = $"King"

@export var min_spawn_dist_from_king = 250

enum SpawnableEnemyTypes {
	PAWN,
	BISHOP,
	ROOK
}

func _ready():
	SigBus.PawnHitBound.connect(_on_pawn_hit_bound)
	enemy_spawn_timer.timeout.connect(_on_enemy_spawn_timer_timeout)
	enemy_spawn_timer.start()

func _on_enemy_spawn_timer_timeout():
	var spawn_location: PathFollow2D = get_node_or_null("EnemySpawnPath/EnemySpawnLocation")
	
	if not spawn_location:
		print("Error! Enemy spawn location couldn't be gotten!")
		return
	
	# we can change this later to see if we want to spawn pawns away from the king
	spawn_location.progress_ratio = randf()
	while spawn_location.global_position.distance_to(king.global_position) < max_spawn_dist_from_king:
		spawn_location.progress_ratio = randf()
	
	#choose who to spawn
	var spawn_type = SpawnableEnemyTypes.values().pick_random()
	
	#create the correct enemy
	match spawn_type:
		SpawnableEnemyTypes.PAWN:
			_spawn_pawn_at_position(spawn_location)
		SpawnableEnemyTypes.BISHOP:
			var new_bishop = Bishop.new_bishop()
			_spawn_piece_at_location(new_bishop, spawn_location)
		SpawnableEnemyTypes.ROOK:
			var new_rook = RookEnemy.new_rook()
			_spawn_piece_at_location(new_rook, spawn_location)
			
	
	#increase timer if wave has increased
	if Global.game_manager.wave < 2:
		enemy_spawn_timer.wait_time = 4
	elif Global.game_manager.wave < 4:
		enemy_spawn_timer.wait_time = 2
	elif Global.game_manager.wave < 6:
		enemy_spawn_timer.wait_time = 1
	elif Global.game_manager.wave < 8:
		enemy_spawn_timer.wait_time = 0.7
	elif Global.game_manager.wave < 10:
		enemy_spawn_timer.wait_time = 0.4
	else:
		enemy_spawn_timer.wait_time = 0.1

func _spawn_pawn_at_position(spawn_location: PathFollow2D):
	var pawn: Pawn = Pawn.new_pawn()
	pawn.position = spawn_location.position

	# set pawn's direction perpendicular to the path direction.
	var rotation_inwards = spawn_location.rotation + PI / 2
	pawn.set_velocity_with_rotation(rotation_inwards)

	# spawn the pawn
	add_child(pawn)

func _spawn_piece_at_position(new_piece, spawn_position: Vector2) -> void:
	#set piece position
	new_piece.position = spawn_position
	
	#add to tree
	add_child(new_piece)

func _spawn_piece_at_location(new_piece, spawn_location: PathFollow2D) -> void:
	_spawn_piece_at_position(new_piece, spawn_location.position)
	
func _on_pawn_hit_bound(pawn_position: Vector2) -> void:
	var new_queen = Queen.new_queen()
	_spawn_piece_at_position(new_queen, pawn_position)

static func new_scene() -> JohnTest:
	var new_s = TEST_SCENE.instantiate()
	return new_s
