extends Area2D

var speed: float = 600.0
var direction := Vector2.RIGHT

@onready var sprite = get_node("Sprite2D")

func _physics_process(delta: float) -> void:
	position += speed * direction * delta