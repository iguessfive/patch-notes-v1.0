class_name WeaponResource
extends Resource
@export_group("timing")
@export var fire_rate: float
@export var reload_time: float
@export_group("variables")
@export var damage: float
@export var knockback: float
@export var max_ammo: int
@export var spread: float
@export_group("recoil")
@export var recoil: Vector3
@export var snappiness: float
@export var return_speed: float
@export_group("nodes")
@export var mesh: PackedScene
