extends CharacterBody2D

func _init() -> void:
	add_to_group("player_2d")

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:

	var x_dir := (int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A)))
	var y_dir := (int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W)))

	var direction := Vector2(x_dir, y_dir).normalized()

	velocity = direction * 200.0
	
	move_and_slide()
