extends Node3D

func _ready():
	$StaticBody3D.connect("mouse_entered", _on_mouse_entered.bind($StaticBody3D))
	$StaticBody3D.connect("mouse_exited", Global.builder._hide_preview)
	$StaticBody3D.connect("input_event", _on_collider_input.bind($StaticBody3D))

func _on_mouse_entered(body):
	if Global.placing_mode == Global.modes.MODULE:
		Global.builder._place_preview(body)

func _on_collider_input(_camera, event: InputEvent, _event_position, _normal, _shape_idx, body):
	if event.is_action_pressed("main_mouse_button") and Global.placing_mode == Global.modes.MODULE:
		Global.builder._place_instance(body, self)
	elif event.is_action_pressed("secondary_mouse_button"):
		Global.control._open_dock_window()

#externally accessed variables
var index_in_module: int
var module_type: String
