extends Area3D

@export var pickupable_node: Node3D
signal picked_up(body: Node3D)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(pickup_weapon)


# for later.
func display_pickup_ui():
	pass


func pickup_weapon(body: Node3D):
	picked_up.emit(body)
	set_deferred("monitoring", false)


func drop_weapon():
	pickupable_node.reparent(get_tree().root)
	set_deferred("monitoring", true)
