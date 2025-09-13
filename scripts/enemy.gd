extends CharacterBody3D

@export var health: Node
@export var speed: float = 10.0
@export var homing_interval: float = 0.1
@export var homing_strength: float = 5.0

var player: Node3D
var homing_timer: float = 0.0

signal died


func take_damage(value: int):
	health.take_damage(value)
	if health.current_health <= 0:
		emit_signal("died")


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

	# Connect health death signal to our own died signal
	if health.has_method("connect"):
		health.connect("died", Callable(self, "_on_health_died"))


func _physics_process(delta: float) -> void:
	homing_timer += delta

	if homing_timer >= homing_interval and player != null:
		homing_timer = 0.0

		# Calculate direction to player
		var direction = (player.position - position).normalized()

		# Apply homing force
		velocity = velocity.lerp(direction * speed, homing_strength * delta)

		# Update rotation to face the direction of movement
		if velocity.length() > 0.1:
			rotation.y = atan2(-velocity.x, velocity.z)
	move_and_slide()


func _on_health_died():
	emit_signal("died")
	queue_free()
