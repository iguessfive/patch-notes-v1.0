extends Node2D

const MAX_SLOTS = 4

@onready var item_container: Node2D = get_node("ItemContainer")

@warning_ignore("unused_parameter")
func _process(delta) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = global_position.direction_to(mouse_pos)
	rotation = direction.angle()

func _on_area_entered(area:Area2D) -> void:
	if item_container.get_child_count() >= MAX_SLOTS: # free slots?
		print_rich("[color=purple]no free slots[/color]")
		return

	if area.is_in_group("items"):
		var slot_radius: float = 50
		var slot := Type.ItemSlot.instantiate()

		slot.item = area.item # store data
		 
		item_container.add_child(slot)
		
		for idx in item_container.get_child_count():
			var item := item_container.get_child(idx)
			var count := item_container.get_child_count()
			var angle := (TAU / count) * idx
			var pos := global_position + Vector2(cos(angle), sin(angle)) * slot_radius
			item.position = pos




	






	
