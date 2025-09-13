@tool
@icon("res://assets/icons/hurt_box.png")
class_name HurtBox2D extends Area2D

signal hurt(hit_box: HitBox2D)

const BIT_PLAYER := 1 << 0
const BIT_MOB := 1 << 1

@export_flags("player", "mob") var source: int = BIT_PLAYER: set = set_source
@export_flags("player", "mob") var target: int = BIT_MOB: set = set_target

func _init() -> void:
	area_entered.connect(func(area: Area2D) -> void:
		if area is HitBox2D:
			hurt.emit(area)
	)

func set_source(new_value: int) -> void:
	source = new_value
	collision_layer = source

func set_target(new_value: int) -> void:
	target = new_value
	collision_mask = target
