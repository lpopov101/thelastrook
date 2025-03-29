class_name King extends Node2D

# An integer from 0-7 describing which direction the king is moving
var direction: int
# The max (Manhattan) distance in pixels from the center the king is willing to move
var MAX_DIST: int

var pi = 3*acos(.5)

func _on_king_movement_timer_timeout() -> void:
	print(pi)
