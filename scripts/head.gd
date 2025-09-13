extends Node3D

@export var camera: Camera3D
@export var mouse_sensitivity: float = 0.01
@export var vertical_look_limit: float = 90.0
@export var player_body: CharacterBody3D

var camera_x_rotation: float


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion:
		return

	var mouse_motion = event as InputEventMouseMotion

	player_body.rotate_y(-mouse_motion.relative.x * mouse_sensitivity)

	camera_x_rotation += -mouse_motion.relative.y * mouse_sensitivity
	camera_x_rotation = clamp(
		camera_x_rotation, deg_to_rad(-vertical_look_limit), deg_to_rad(vertical_look_limit)
	)

	rotation.x = camera_x_rotation
