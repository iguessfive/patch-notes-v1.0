extends CharacterBody2D

var speed: float = 0.0
var direction := Vector2.RIGHT
var distance_max: float = 0.0
var damage: int = 0: set = set_damage

var distance_traveled: float = 0.0

@onready var hit_box = %HitBox2D

@onready var sprite = get_node("Sprite2D")

func _ready() -> void:
	hit_box.hit.connect(_on_hit)

func _physics_process(delta: float) -> void:
	velocity = speed * direction
	move_and_slide()

	distance_traveled += speed * delta
	if distance_traveled > distance_max:
		destroy()

func destroy() -> void:
	queue_free()

@warning_ignore("unused_parameter")
func _on_hit(area: HurtBox2D) -> void:
	# Bullet VFX & SFX
	destroy()

func set_damage(value: int) -> void:
	damage = value
	hit_box.effect_value = damage