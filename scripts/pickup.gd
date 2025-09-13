extends Area2D

@export var item: Script # defined behaviour of item

var item_obj: Node

func _init() -> void:
	add_to_group("items")
	
func _ready() -> void:
	item_obj = item.new()

	var sprite: Sprite2D = get_node("Sprite2D")
	sprite.modulate = item_obj.resource.color # placeholder for texture

func get_item_obj() -> Node2D:
	destroy() 
	return item_obj

func destroy() -> void:
	queue_free()
