extends StaticBody3D

@export_file var arcade_game := "res://%s/main.tscn" % Type.SUB_FOLDER

@onready var screen_mesh: MeshInstance3D = $Model/ScreenMesh
@onready var interact_area: Area3D =  $InteractArea

var is_within_interact_area: bool = false

func _ready() -> void:
	if not InputMap.has_action("enter_arcade"):
		InputMap.add_action("enter_arcade")
		var event := InputEventKey.new()
		event.physical_keycode = KEY_E
		InputMap.action_add_event("enter_arcade", event)

	interact_area.body_entered.connect(func(body: Node) -> void:
		if body is Type.Player3D:
			is_within_interact_area = true
			$Label3D.show()
	)

	interact_area.body_exited.connect(func(body: Node) -> void:
		if body is Type.Player3D:
			is_within_interact_area = false
			$Label3D.hide()
	)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if is_within_interact_area and Input.is_action_pressed("enter_arcade"):
		print(is_within_interact_area)
		get_tree().change_scene_to_file.call_deferred(arcade_game)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE