extends Node

signal health_changed(currentHealth: int, maxHealth: int)

@export var current_health: float
@export var max_health: float


func take_damage(damage: int):
	current_health -= damage
	health_changed.emit(current_health, max_health)
	print("damage taken : " + str(damage))


func heal(value: int):
	current_health += value
	health_changed.emit(current_health, max_health)


func update_max_health(value: int):
	max_health += value
	health_changed.emit(current_health, max_health)
