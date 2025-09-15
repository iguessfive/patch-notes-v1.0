extends CharacterBody2D

@export var hurt_box: HurtBox2D
@export var hit_box: HitBox2D

var resource := Type.MobResource.new()
var state_machine = CallableStateMachine.new()
var state_flag = BoolFlag.new()

func _process(delta: float) -> void:
	state_machine.update(delta)

func _physics_process(delta: float) -> void:
	state_machine.update_physics(delta)

func init_resource() -> void:
	pass