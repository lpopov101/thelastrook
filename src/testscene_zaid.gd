extends Node2D

const PAWN_SCENE: PackedScene = preload("uid://mmkclxn06vhw") # pawn.tscn

func _on_pawn_spawn_timer_timeout():
	var pawn_spawn_location: PathFollow2D = get_node_or_null("PawnSpawnPath/PawnSpawnLocation")
	
	if not pawn_spawn_location:
		print("Error! Pawn spawn location couldn't be gotten!")
		return
	
	# we can change this later to see if we want to spawn pawns away from the king
	pawn_spawn_location.progress_ratio = randf()
	_spawn_pawn_at_position(pawn_spawn_location)


func _spawn_pawn_at_position(pawn_spawn_location: PathFollow2D):
	var pawn: Pawn = PAWN_SCENE.instantiate()
	pawn.position = pawn_spawn_location.position

	# set pawn's direction perpendicular to the path direction.
	var rotation_inwards = pawn_spawn_location.rotation + PI / 2
	pawn.set_velocity_with_rotation(rotation_inwards)

	# spawn the pawn
	add_child(pawn)
