@tool
@icon("res://assets/icons/hit_box.png")
class_name HitBox2D extends Area2D

signal hit(hurt_box: HurtBox2D)

const BIT_PLAYER := 1 << 0
const BIT_MOB := 1 << 1

@export var effect_value: int = 0

@export_flags("player", "mob") var source: int = BIT_PLAYER: set = set_source
@export_flags("player", "mob") var target: int = BIT_MOB: set = set_target

func _init() -> void:
	area_entered.connect(func(area: Area2D) -> void:
		if area is HurtBox2D:
			hit.emit(area)
	)
	
func set_source(new_value: int) -> void:
	source = new_value
	collision_layer = source

func set_target(new_value: int) -> void:
	target = new_value
	collision_mask = target
