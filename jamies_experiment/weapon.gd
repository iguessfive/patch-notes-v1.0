extends Node3D

@export var head: Node3D
@export var head_raycast: RayCast3D
@export var debug_sphere: CSGSphere3D
@export var weapon_resource: WeaponResource:
	set = init_weapon
@export var shoot_timer: Timer
@export var reload_timer: Timer
@export var audioStreamPlayer: AudioStreamPlayer3D
var damage: float
var spread: float
var recoil: float
var knockback: float
var shoot_sfx: AudioStream
var reload_sfx: AudioStream
var shoot_vfx: PackedScene
var reload_vfx: PackedScene
var mesh: PackedScene


func _ready() -> void:
	var tmpmesh = mesh.instantiate()
	add_child(tmpmesh)
	tmpmesh.rotation_degrees.y = 90


func _process(delta: float):
	var point = head_raycast.get_collision_point()
	debug_sphere.position = point
	if Input.is_action_pressed("fire"):
		fire_weapon()


func fire_weapon():
	shoot_timer.start()
	if shoot_sfx != null:
		audioStreamPlayer.stream = shoot_sfx
		audioStreamPlayer.play()


func reload_weapon():
	reload_timer.start()
	if reload_sfx != null:
		audioStreamPlayer.stream = reload_sfx
		audioStreamPlayer.play()


func init_weapon(resource: WeaponResource):
	damage = resource.damage
	spread = resource.spread
	recoil = resource.recoil
	knockback = resource.knockback
	shoot_sfx = resource.shoot_sfx
	shoot_sfx = resource.shoot_sfx
	reload_vfx = resource.reload_vfx
	reload_vfx = resource.reload_vfx
	mesh = resource.mesh
	shoot_timer.wait_time = weapon_resource.fire_rate
	reload_timer.wait_time = weapon_resource.reload_time
