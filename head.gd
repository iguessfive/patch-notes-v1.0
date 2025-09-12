extends Node3D

@export var camera: Camera3D
@export var mouse_sensitivity: float
@export var x_clamp_bounds: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera.rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf(camera.rotation.x, -x_clamp_bounds, x_clamp_bounds)
