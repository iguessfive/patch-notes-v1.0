extends Area3D

@export var pickupable_node: Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(pickup_weapon)


func pickup_weapon(body: Node3D):
	# move to the players gun point and parent ourselves to that.
	var mountpoint = body.get_node_or_null("Head/GunMountPoint")
	if mountpoint == null:
		push_error("something is wrong where is your gunpoint")
	pickupable_node.position = Vector3.ZERO
	pickupable_node.call_deferred("reparent", mountpoint, false)
	monitoring = false


func drop_weapon():
	print("weapon dropped")
	pickupable_node.reparent(get_tree().root)

	monitoring = true
