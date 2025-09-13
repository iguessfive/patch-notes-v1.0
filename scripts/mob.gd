extends CharacterBody2D

enum State {
	IDLE,
	CHASE,
}

@export var hurt_box: HurtBox2D
@export var mob_resource = Type.MobResource.new()

var state_machine = CallableStateMachine.new()
var state_flag = BoolFlag.new()

func _ready() -> void:
	# Config States
	state_machine.add_state(State.CHASE, _on_chase_enter, _on_chase_update, Callable())

	state_machine.set_initial_state(State.CHASE)
	hurt_box.hurt.connect(on_hurt)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	state_machine.update()

func _on_chase_enter() -> void:
	chase_anim()

func _on_chase_update() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * 100.0
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
		destroy()

func destroy() -> void:
	# Death VFX & SFX
	queue_free()
	
