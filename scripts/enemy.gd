extends CharacterBody3D

@export var health: Node


func take_damage(value: int):
	health.take_damage(value)
