class_name Entity
extends CharacterBody3D

@export var current_health: float
@export var max_health: float
@export var min_health: float
@export var armor: float

# Agent the layer that communicates between both the damager and damagee

# leave this for you (abdoul)
# func hit(Agent: Node):
# 	health -= damage_amount
