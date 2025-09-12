extends Area2D

@export var item: Script

var item_obj

func _init() -> void:
	add_to_group("items")
	
func _ready() -> void:
	item_obj = item.new()

	visible = true
	var sprite: Sprite2D = get_node("Sprite2D")
	sprite.modulate = item_obj.data.color # placeholder instead of texture

func get_item_obj() -> Node2D:
	destroy() # availible to send obj?
	return item_obj

func destroy() -> void:
	queue_free()
