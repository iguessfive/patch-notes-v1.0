extends CharacterBody2D

enum State {
	IDLE
}

var state_machine = CallableStateMachine.new()
var state_flag = BoolFlag.new()

func _ready() -> void:
	# Config States
	state_machine.add_state(State.IDLE, _on_idle_enter, _on_idle_update, Callable())

	state_machine.set_initial_state(State.IDLE)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	state_machine.update()

func _on_idle_enter() -> void:
	idle_anim()

func _on_idle_update() -> void:
	print(get_tree().get_first_node_in_group("player"))
	print("idling")

func idle_anim() -> void:
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0.5, 1)
	tween.tween_property($Sprite2D, "modulate:a", 1, 1)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_loops()

	
