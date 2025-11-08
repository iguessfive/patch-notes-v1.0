extends CharacterBody2D

@export var max_speed: float = 100.0
@export var friction: float = 10.0
@export var acceleration: float = 20.0
@export var jump_velocity: float = -400.0

var direction: float = 0.0
var anchor_point: Vector2 = Vector2() # keep it grounded at ground collision point

func _process(_delta: float) -> void:
	direction = Input.get_axis("left", "right")
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		squash(0.8, Vector2Axis.new(0, 1), 0.2)
	elif Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = jump_velocity
		scale = Vector2(1, 1)
		stretch(0.5, Vector2Axis.new(1, 0), 0.02, func(): scale = Vector2(1, 1))
		
	velocity.x = (velocity.x + (acceleration * direction) - (sign(velocity.x) * friction))
	clampf(velocity.x, -max_speed, max_speed)
	move_and_slide()


func squash(subtraction: float, axis: Vector2Axis, duration: float = 0.2, callback: Callable = Callable()) -> void:
	print_debug(axis.to_vector2(), axis.get_inverse().to_vector2())
	var target_scale = scale - (axis.to_vector2() * subtraction) + (axis.get_inverse().to_vector2() * subtraction)
	
	if callback != Callable():
		create_tween().tween_property(self, "scale", target_scale, duration).finished.connect(callback)
	else:
		create_tween().tween_property(self, "scale", target_scale, duration)
	
	get_tree().create_timer(duration).timeout.connect(func() -> void:
		scale = scale.clamp(Vector2(0.5, 0.5), Vector2(1.5, 1.5))
	)
	

func stretch(addition: float, axis: Vector2Axis, duration: float = 0.2, callback: Callable = Callable()) -> void:
	var target_scale = scale + (axis.to_vector2() * addition) - (axis.get_inverse().to_vector2() * addition)
	
	if callback != Callable():
		create_tween().tween_property(self, "scale", target_scale, duration).finished.connect(callback)
	else:
		create_tween().tween_property(self, "scale", target_scale, duration)
	
	await get_tree().create_timer(duration).timeout
	scale = scale.clamp(Vector2(0.5, 0.5), Vector2(1.5, 1.5))


func reset_scale(speed: float = 5.0) -> void:
	scale = scale.lerp(Vector2.ONE, speed * get_physics_process_delta_time())
