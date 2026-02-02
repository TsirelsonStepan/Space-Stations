extends Node3D

func _ready():
	for body in $DockPlaces.get_children():
		body.connect("mouse_entered", _on_mouse_entered.bind(body))
		body.connect("mouse_exited", Global.builder._hide_preview)
		body.connect("input_event", _on_collider_input.bind(body))
	$StaticBody3D.connect("input_event", _on_general_module_cicked)

func _on_mouse_entered(body):
	if Global.placing_mode == Global.modes.DOCK:
		Global.builder._place_preview(body)

func _on_collider_input(_camera, event: InputEvent, _event_position, _normal, _shape_idx, body):
	if Global.placing_mode == Global.modes.NONE: _on_general_module_cicked(null, event, null, null, null)
	elif Global.placing_mode == Global.modes.DOCK and event.is_action_pressed("main_mouse_button"):
		Global.builder._place_instance(body, self)

func _on_general_module_cicked(_camera, event: InputEvent, _event_position, _normal, _shape_idx):
	if event.is_action_pressed("main_mouse_button"):
		Global.control._open_module_window(self)
		_toggle_highlight(true)
	elif event.is_action_pressed("secondary_mouse_button"):
		Global.camera._move_center(get_position())

func _toggle_highlight(state: bool):
	if state: $module.get_node("Cylinder").set_surface_override_material(0, load("res://module_override_material.tres"))
	else: $module.get_node("Cylinder").set_surface_override_material(0, null)

#externally accessed variables
var data_structure_id: int
var module_type: String
var uri: String
