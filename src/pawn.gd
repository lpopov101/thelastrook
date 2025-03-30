class_name Pawn extends CharacterBody2D

@export var speed : float = 100.0 # default

# _init runs on instantiation. _ready runs on node addition to tree :)
func _init():
	velocity = Vector2(speed, 0.0)

func _physics_process(_delta: float):
	move_and_slide()


func set_velocity_with_rotation(rotation: float):
	velocity = velocity.rotated(rotation)
