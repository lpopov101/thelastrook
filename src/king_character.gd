class_name KingCharacter extends CharacterBody2D

# The max (Manhattan) distance in pixels from the starting point the king is willing to move
var MAX_DIST = 300
# Self explanatory
var SPEED = 10000
var HEALTH = 10
var INVINCIBILITY_MS = 100
var LAST_DAMAGE_TIME = -100

# Other not important stuff
var direction = 0
var pi = 3*acos(.5)
var dx = 0
var dy = 0
var startX = 0
var startY = 0

@onready var king_character: KingCharacter = $"."

func _ready() -> void:
	startX = self.position.x
	startY = self.position.y
	_on_king_movement_timer_timeout()

func _on_king_movement_timer_timeout() -> void:
	direction = randi() % 8
	dx = cos(direction * pi/4)
	dy = sin(direction * pi/4)

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if (abs(self.position.x + (delta * SPEED * dx) - startX) + abs(self.position.y + (delta * SPEED * dy) - startY) < MAX_DIST):
		velocity = Vector2(dx, dy) * SPEED * delta
	move_and_slide()

func take_damage(damage: int):
	var cur_time = Time.get_ticks_msec()
	if cur_time - LAST_DAMAGE_TIME > INVINCIBILITY_MS:
		HEALTH -= damage
		print("King took damage: ", damage, " HP left: ", HEALTH)
		LAST_DAMAGE_TIME = cur_time
