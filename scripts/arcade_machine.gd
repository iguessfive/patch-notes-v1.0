extends StaticBody3D

@export var shooter_2d_path := "res://%s/main.tscn" % Type.SUB_FOLDER

@onready var screen_mesh: MeshInstance3D = $Model/ScreenMesh
@onready var interact_area: Area3D =  $InteractArea

func _ready() -> void:
	interact_area.body_entered.connect(func(body: Node) -> void:
		if body is Type.Player3D:
			get_tree().change_scene_to_file.call_deferred(shooter_2d_path)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	)
