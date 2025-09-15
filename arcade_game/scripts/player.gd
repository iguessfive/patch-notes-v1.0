extends CharacterBody2D

@export var health: int = 3: set = set_health

var direction := Vector2()

@onready var hurt_box: HurtBox2D = $HurtBox2D
@onready var health_ui: HBoxContainer = $UI/Health

func _init() -> void:
	add_to_group("player_2d")

func _ready() -> void:
	hurt_box.hurt.connect(on_hurt)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:

	var x_dir := (int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A)))
	var y_dir := (int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W)))

	direction = Vector2(x_dir, y_dir).normalized()

	var viewport_rect := get_viewport_rect()
	position.x = clamp(position.x, 0, viewport_rect.size.x)
	position.y = clamp(position.y, 0, viewport_rect.size.y)

	velocity = direction * 200.0
	move_and_slide()

func set_health(value: int) -> void:
	health = value

	for idx in range(health_ui.get_child_count()):
		health_ui.get_child(idx).visible = idx < health
	
	print(health)

func on_hurt(hit: HitBox2D) -> void:
	print_rich("[color=yellow]Health: %d, Damage: %d[/color]" % [health, hit.effect_value])
	print(hit.owner.name)
	health -= hit.effect_value

	if health <= 0:
		print_rich("[color=red]Player Died![/color]")
		get_tree().change_scene_to_file.call_deferred(ScenePath.Shooter3D)
