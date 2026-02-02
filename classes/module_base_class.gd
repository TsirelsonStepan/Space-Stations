extends Node3D
class_name BaseModule

@export var general_collider: StaticBody3D

#collider attachement
func _ready() -> void:
	general_collider.connect("input_event", _input_event)

#info window opening
func _input_event(_camera, event: InputEvent, _event_position, _normal, _shape_idx):
	if event.is_action_pressed("main_mouse_button"):
		#Global.control._open_module_window(self)
		_toggle_highlight(true)

func _toggle_highlight(state: bool):
	if state: $object.get_child(0).set_surface_override_material(0, load("res://module_override_material.tres"))
	else: $object.get_child(0).set_surface_override_material(0, null)
