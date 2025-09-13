extends Area2D

var speed: float = 600.0
var direction := Vector2.RIGHT
var distance_max: float = 1000.0

var distance_traveled: float = 0.0

@onready var sprite = get_node("Sprite2D")

func _physics_process(delta: float) -> void:
	position += speed * direction * delta

	distance_traveled += speed * delta
	if distance_traveled > distance_max:
		destroy()

func destroy() -> void:
	queue_free()