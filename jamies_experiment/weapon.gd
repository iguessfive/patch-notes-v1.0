extends Node3D

@export var head: Node3D
@export var head_raycast: RayCast3D
@export var debug_sphere: CSGSphere3D
@export var weapon_resource: WeaponResource:
	set = init_weapon
@export var timer: Timer
@export var audioStreamPlayer: AudioStreamPlayer3D
var damage: float
var fire_rate: float
var reload_time: float
var spread: float
var recoil: float
var knockback: float
var shoot_sfx: AudioStream
var reload_sfx: AudioStream
var shoot_vfx: PackedScene
var reload_vfx: PackedScene


func fire_weapon():
	timer.wait_time = weapon_resource.fire_rate
	timer.start()
	audioStreamPlayer.stream = shoot_sfx
	audioStreamPlayer.play()


func reload_weapon():
	timer.wait_time = weapon_resource.reload_time
	timer.start()
	audioStreamPlayer.stream = reload_sfx
	audioStreamPlayer.play()


func init_weapon(resource: WeaponResource):
	fire_rate = resource.fire_rate
	damage = resource.damage
	reload_time = resource.reload_time
	spread = resource.spread
	recoil = resource.recoil
	knockback = resource.knockback
	shoot_sfx = resource.shoot_sfx
	shoot_sfx = resource.shoot_sfx
	reload_vfx = resource.reload_vfx
	reload_vfx = resource.reload_vfx


func _process(_delta):
	var point = head_raycast.get_collision_point()
	debug_sphere.position = point
