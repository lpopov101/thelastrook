class_name King extends Node2D

# The max (Manhattan) distance in pixels from the center the king is willing to move
var MAX_DIST = 300
# Self explanatory
var SPEED = 50
signal DamagedKing

# Other not important stuff
var direction = 0
var pi = 3*acos(.5)
var dx = 0
var dy = 0

@onready var king: King = $"."

func _ready() -> void:
	_on_king_movement_timer_timeout()

func _on_king_movement_timer_timeout() -> void:
	direction = randi() % 8
	dx = cos(direction * pi/4)
	dy = sin(direction * pi/4)

func _physics_process(delta: float) -> void:
	if (abs(self.position.x + (delta * SPEED * dx)) + abs(self.position.y + (delta * SPEED * dy)) < MAX_DIST):
		self.position.x += delta * SPEED * dx
		self.position.y += delta * SPEED * dy

func _on_king_hitbox_body_entered(body: Node2D) -> void:
	DamagedKing.emit()
