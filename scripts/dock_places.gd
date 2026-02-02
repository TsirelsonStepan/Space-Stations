extends Node3D

func _ready() -> void:
	for child in get_children():
		if child is StaticBody3D:
			child.connect("mouse_entered", _on_mouse_entered.bind(child))
			child.connect("mouse_exited", _on_mouse_exited.bind(child))
			child.connect("input_event", _on_input_event.bind(child))

func _on_mouse_entered(body: StaticBody3D) -> void:
	if Planner.current_preview: Planner._place_preview(body)

func _on_mouse_exited(_body: StaticBody3D) -> void:
	if Planner.current_preview: Planner._hide_preview()

func _on_input_event(_camera, event: InputEvent, _event_position, _normal, _shape_idx, _body: StaticBody3D) -> void:
	if !Planner.current_preview:
		$"../GeneralCollider"._on_input_event(null, event, null, null, null)
	elif event.is_action_pressed("mouse_1"):
		Planner._place_project()
