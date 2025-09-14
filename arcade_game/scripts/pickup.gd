extends Area2D

@export var item: Script # defined behaviour of item
@export var duration_remain: float = 5.0

var item_obj: Node

func _init() -> void:
	add_to_group("items")
	
func _ready() -> void:
	get_tree().create_timer(duration_remain).timeout.connect(destroy)

	if item:
		item_obj = item.new()
		var sprite: Sprite2D = get_node("Sprite2D")
		sprite.texture = item_obj.resource.texture

func get_item_obj() -> Node2D:
	destroy() 
	return item_obj

func destroy() -> void:
	queue_free()
