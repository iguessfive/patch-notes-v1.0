extends AnimatedSprite2D

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	var player: Type.Player2D = get_tree().get_first_node_in_group("player_2d")
	if player and player.direction.length() > 0:
		play("run")
		flip_h = player.direction.x < 0

	else:
		play("idle")
