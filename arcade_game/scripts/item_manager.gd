extends Area2D

const MAX_SLOTS = 10

@onready var item_container: Node2D = get_node("ItemContainer")

func _ready() -> void:
	area_entered.connect(_on_area_entered)

@warning_ignore("unused_parameter")
func _process(delta) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = global_position.direction_to(mouse_pos)
	rotation = direction.angle()

func _on_area_entered(body: Node) -> void:
	if item_container.get_child_count() >= MAX_SLOTS: # free slots?
		print_rich("[color=purple]no free slots[/color]")
		return

	if body.is_in_group("items"):
		var item_obj = body.get_item_obj()
		item_container.add_child(item_obj)
		print(item_container.get_child_count())
		item_obj.holder = get_parent()

		var radius: float = randi_range(40, 60)
		for idx in item_container.get_child_count():
			var item := item_container.get_child(idx)
			var count := item_container.get_child_count()
			var angle := (TAU / count) * idx
			var pos = Vector2(cos(angle), sin(angle)) * radius
			item.sprite.rotation = angle
			item.position = pos





	






	
