extends Type.Mob

enum State {
	CHASE
}

func _ready() -> void:
	# Config States
	state_machine.add_state(State.CHASE, _on_chase_enter, _on_chase_update, Callable(), Callable())

	state_machine.set_initial_state(State.CHASE)
	hurt_box.hurt.connect(on_hurt)

func _on_chase_enter() -> void:
	chase_anim()

@warning_ignore("unused_parameter")
func _on_chase_update(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * mob_resource.speed_movement
		move_and_slide()

func chase_anim() -> void:
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0.5, 1)
	tween.tween_property($Sprite2D, "modulate:a", 1, 1)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_loops()

func on_hurt(hit_box: HitBox2D) -> void:
	mob_resource.health -= hit_box.effect_value
	print_rich("[color=cyan]Mob Health: %d[/color]" % mob_resource.health)
	if mob_resource.health <= 0:
		drop_item.call_deferred()
		destroy()

func destroy() -> void:
	# Death VFX & SFX
	queue_free()

func drop_item() -> void:
	var pickup = preload("res://scenes/pickup.tscn").instantiate()
	pickup.item = Type.Weapon
	get_tree().current_scene.add_child(pickup)
	pickup.global_position = global_position
	
