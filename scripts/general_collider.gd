extends StaticBody3D

func _ready() -> void:
	connect("input_event", _on_input_event)

func _on_input_event(_camera, event: InputEvent, _event_position, _normal, _shape_idx) -> void:
	if event.is_action_pressed("mouse_1"):
		HighlightToggle._toggle_module($"../Mesh", true)
		UI.module_window._open()
		pass
	elif event.is_action_pressed("mouse_2"):
		get_tree().get_root().get_node("Origin/CameraHolder/Camera3D")._move_center(get_parent().get_global_position())
	pass
