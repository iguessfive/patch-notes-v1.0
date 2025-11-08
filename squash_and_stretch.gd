extends CharacterBody2D

@export var jump_height: float = -400.0

var speed: float = 200.0
var impact_force: float = 0.0

# fist squash downwards then on release stretch upwards and back to normal

@onready var pivot = $Pivot

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_height
	
	if not is_on_floor() and velocity.y < 0:
		pivot.scale.y = remap(abs(velocity.y), 0, abs(jump_height), 1, 1.5)
		pivot.scale.x = remap(abs(velocity.y), 0, abs(jump_height), 1, 0.75)

	#region Horizontal Movement
	var direction: float = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = lerpf(velocity.x, 0, 1 - pow(0.005, delta))
	#endregion

	move_and_slide()

	if not is_on_floor() and velocity.y > 0:
		impact_force += velocity.y * delta
	
	if is_on_floor():
		pivot.scale.y = remap(abs(impact_force), 0, abs(jump_height), 1, 0.1)
		pivot.scale.x = remap(abs(impact_force), 0, abs(jump_height), 1, 5.0)
		impact_force = lerpf(impact_force, 0, 1 - pow(0.005, delta))

func squash(motion: float, factor: float, dt: float, callback: Callable = Callable()) -> void:
	pass

func stretch(motion: float, factor: float, dt: float, callback: Callable = Callable()) -> void:
	pass

func reset_scale() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.3)
