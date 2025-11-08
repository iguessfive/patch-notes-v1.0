extends CharacterBody2D

@export var max_jump_height: float = -600.0
@export var max_speed: float = 400.0
@export var min_jump_ratio: float = 0.5

var speed: float = 0.0
var jump_height: float = 0.0
var impact_force: float = 0.0

# fist squash downwards then on release stretch upwards and back to normal

@onready var pivot = $Pivot
@onready var collider = $CollisionShape2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_height = max_jump_height * min_jump_ratio if speed / max_speed < 0.5 else max_jump_height * speed / max_speed
		velocity.y = jump_height
	
	if not is_on_floor() and velocity.y < 0:
		pivot.scale.y = remap(abs(velocity.y), 0, abs(max_jump_height), 1, 1.5)
		pivot.scale.x = remap(abs(velocity.y), 0, abs(max_jump_height), 1, 0.75)
		collider.scale.x = pivot.scale.x

	#region Horizontal Movement
	var direction: float = Input.get_axis("left", "right")
	if direction:
		speed = lerpf(speed, max_speed, 1 - pow(0.01, delta))
		velocity.x = direction * speed
	else:
		speed = lerpf(speed, 0, 1 - pow(0.005, delta))
		velocity.x = direction * speed
	#endregion

	move_and_slide()

	if not is_on_floor() and velocity.y > 0:
		impact_force += velocity.y * delta
	
	if is_on_floor():
		pivot.scale.y = remap(abs(impact_force), 0, abs(max_jump_height), 1, 0.1)
		pivot.scale.x = remap(abs(impact_force), 0, abs(max_jump_height), 1, 5.0)
		impact_force = lerpf(impact_force, 0, 1 - pow(0.005, delta))
		collider.scale.x = pivot.scale.x

func squash(motion: float, factor: float, dt: float, callback: Callable = Callable()) -> void:
	pass

func stretch(motion: float, factor: float, dt: float, callback: Callable = Callable()) -> void:
	pass

func reset_scale() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.3)
