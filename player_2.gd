extends CharacterBody2D

@export var max_speed : float = 300.0
@export var friction : float = 6.0
@export var acceleration : float = 20.0
@export var jump_velocity : float = -400.0

@export_group("Stretch")
@export var sprite_scale_at_rest : Vector2 = Vector2(1.0, 1.0)
@export var max_stretch : float = 1.5  # Maximum scale at max_speed

var direction : float
var sprite: Sprite2D
var sprite_dimensions : Vector2
var sprite_virtual_dimensions : Vector2

func _ready() -> void:
	sprite = get_node_or_null("Sprite2D")
	if sprite:
		sprite_dimensions = sprite.texture.get_size()

func _process(_delta: float) -> void:	
	direction = Input.get_axis("left", "right")
	
	if sprite and velocity.length() > 10.0:
		var velocity_normalized = velocity.normalized()
		var speed_over_max_speed = clamp(velocity.length() / max_speed, 0.0, 1.0)
		var stretch_amount = (max_stretch - 1.0) * speed_over_max_speed
		
		# Stretch based on velocity direction (normalized components act like sin/cos)
		sprite.scale.x = sprite_scale_at_rest.x + abs(velocity_normalized.x) * stretch_amount
		sprite.scale.y = sprite_scale_at_rest.y + abs(velocity_normalized.y) * stretch_amount
		
		# Preserve volume by adjusting one axis
		var rest_area = sprite_dimensions.x * sprite_scale_at_rest.x * sprite_dimensions.y * sprite_scale_at_rest.y
		sprite.scale.y = rest_area / (sprite_dimensions.x * sprite.scale.x * sprite_dimensions.y)
		
		# Calculate virtual dimensions
		sprite_virtual_dimensions = sprite_dimensions * sprite.scale
		
		# Offset sprite to keep bottom aligned (assuming collider is centered)
		var sprite_height = sprite_virtual_dimensions.y
		sprite.offset.y = sprite_height / 2.0
	elif sprite:
		sprite.scale = sprite_scale_at_rest
		sprite.offset.y = 0.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
	velocity.x = (velocity.x + ((acceleration * direction) - (sign(velocity.x) * friction)))
	velocity.x = clampf(velocity.x, -max_speed, max_speed)
	move_and_slide()
