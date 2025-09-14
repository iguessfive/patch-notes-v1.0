extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const FRICTION = 0.075  # Friction coefficient for ground movement
const AIR_FRICTION = 0.05  # Friction coefficient for air movement
@export var head: Node3D
signal interact_fired


func _ready() -> void:
	Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED


func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		interact_fired.emit()


func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if not is_on_floor():
		velocity += get_gravity() * delta
		# Apply air friction
		velocity.x *= (1.0 - AIR_FRICTION)
		velocity.z *= (1.0 - AIR_FRICTION)
	else:
		# Apply ground friction when not pressing movement keys
		if input_dir.length() < 0.1:  # No input detected
			velocity.x *= (1.0 - FRICTION)
			velocity.z *= (1.0 - FRICTION)
		else:
			# Reset friction when moving
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

	move_and_slide()


func connect_weapon_knockback(pickup: Node3D):
	pickup.connect("weapon_fired", process_weapon_knockback)


func process_weapon_knockback(knockback_force: float):
	# Get camera's actual forward direction (includes head rotation)
	var camera = head.get_node("Camera3D")
	var camera_forward = -camera.global_transform.basis.z

	# Project onto horizontal plane (remove Y component but keep direction)
	var horizontal_knockback = -(
		Vector3(camera_forward.x, camera_forward.y, camera_forward.z).normalized()
	)

	# print("Camera forward: " + str(camera_forward))
	# print("Horizontal knockback: " + str(horizontal_knockback))

	velocity += Vector3(
		horizontal_knockback.x * knockback_force,
		horizontal_knockback.y * (knockback_force * .5),
		horizontal_knockback.z * knockback_force
	)
