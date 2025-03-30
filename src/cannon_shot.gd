class_name CannonShot extends Area2D

var speed = 100
var direction: Vector2 = Vector2.ZERO

func _init() -> void:
	body_entered.connect(on_body_entered)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func on_body_entered(body: Node) -> void:
	print("Cannon shot hit: ", body.name)
	# TODO: damage logic
	queue_free()
