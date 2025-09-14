extends Node

signal health_changed(currentHealth: int, maxHealth: int)
signal died

@export var current_health: float
@export var max_health: float


func take_damage(damage: int):
	current_health -= damage
	health_changed.emit(current_health, max_health)
	print(self.name + " damage taken : " + str(damage))
	if current_health <= 0:
		died.emit()


func heal(value: int):
	current_health += value
	health_changed.emit(current_health, max_health)


func update_max_health(value: int):
	max_health += value
	health_changed.emit(current_health, max_health)
