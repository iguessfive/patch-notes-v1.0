extends Node2D

@export var data := Type.WeaponResource.new() # attach data to weapon then to pickup?

var holder: CharacterBody2D
var sprite := Sprite2D.new()
var can_fire: bool = true

func _init() -> void:
	add_child(sprite)
	sprite.scale = Vector2(16, 16)
	sprite.texture = Asset.Visual.white_1x1
	sprite.modulate = data.color

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if can_fire:
		var bullet : Type.Bullet = data.bullet.instantiate()
		get_tree().current_scene.add_child(bullet)
		var direction = holder.global_position.direction_to(global_position)
		bullet.direction = direction
		bullet.speed = data.bullet_speed
		bullet.global_position = global_position
		bullet.sprite.modulate = data.color
		can_fire = false
		var fire_rate_timer = get_tree().create_timer(data.fire_rate)
		fire_rate_timer.timeout.connect(func(): can_fire = true)
