extends PanelContainer

var module_selected: Node3D:
	set(value):
		if module_selected: module_selected._toggle_highlight(false)
		module_selected = value



func _on_button_pressed():
	set_visible(false)
	module_selected._toggle_highlight(false)

var mouseOffset: Vector2 = Vector2(0, 0)
var is_dragging: bool = false
func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("main_mouse_button"):
		is_dragging = true
		mouseOffset = position - get_viewport().get_mouse_position()
	if is_dragging:
		position = get_viewport().get_mouse_position() + mouseOffset
	if event.is_action_released("main_mouse_button"):
		is_dragging = false
		mouseOffset = Vector2(0, 0)

#add info display
