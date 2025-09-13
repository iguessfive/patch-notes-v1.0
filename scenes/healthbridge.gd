extends MeshInstance3D


func _on_health_health_changed(currentHealth: int, maxHealth: int) -> void:
	var fl_val: float = float(currentHealth) / float(maxHealth)
	mesh.surface_get_material(0).set("shader_parameter/fill_amount", fl_val)
	# mesh.surface_get_material(0).set("shader_parameter/coeff", Vector2(0, 1))
	# mesh.surface_get_material(0).set("shader_parameter/vel", 1)
