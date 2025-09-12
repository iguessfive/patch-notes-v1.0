extends Node3D

@export var head_raycast: RayCast3D
@export var debug_sphere: CSGSphere3D
@export var weapon_resource: WeaponResource
@export var shoot_timer: Timer
@export var reload_timer: Timer
@export var audioStreamPlayer: AudioStreamPlayer3D
var mesh: PackedScene
var current_ammo: int
signal weapon_fired(knockback)


func _ready() -> void:
	init_weapon(weapon_resource)
	var tmpmesh = mesh.instantiate()
	add_child(tmpmesh)
	tmpmesh.rotation_degrees.y = 90
	reload_timer.connect("timeout", reload_weapon)
	# shoot_timer.connect("timeout", shoot_weapon)


func _process(_delta: float):
	if $Pickup.monitoring != true:
		if Input.is_action_pressed("fire"):
			fire_weapon_shooting_timer()


func fire_weapon_shooting_timer():
	if shoot_timer.is_stopped() and reload_timer.is_stopped():
		var point = head_raycast.get_collision_point()
		debug_sphere.position = point
		print("gun shot, cooldown started")
		if current_ammo > 1:
			current_ammo -= 1
		else:
			fire_reload_weapon_timer()
		weapon_fired.emit(weapon_resource.knockback)
		shoot_timer.start()
	# else:
	# 	print("can't shoot, cooldown still going")


func fire_reload_weapon_timer():
	if shoot_timer.is_stopped() and reload_timer.is_stopped():
		reload_timer.start()
		print("gun reloaded, cooldown started")


func reload_weapon():
	current_ammo = weapon_resource.max_ammo


func init_weapon(resource: WeaponResource):
	mesh = resource.mesh
	current_ammo = resource.max_ammo
	shoot_timer.wait_time = resource.fire_rate
	reload_timer.wait_time = resource.reload_time
	$Pickup.connect("picked_up", picked_up)


func picked_up(body: Node3D):
	if body.name == "Player":
		# move to the players gun point and parent ourselves to that.
		var mountpoint = body.get_node_or_null("Head/GunMountPoint")
		if mountpoint == null:
			push_error("something is wrong where is your gunpoint")
		position = Vector3.ZERO
		call_deferred("reparent", mountpoint, false)
		body.connect_weapon_knockback(self)
