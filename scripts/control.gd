extends Control

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("exit_dock_placing_mode"):
		%Builder._exit_placing_mode()

func _on_build_button_pressed():
	$"./ScrollContainer".set_visible(!$"./ScrollContainer".is_visible())

func _open_module_window(of_module: Node3D):
	$ModuleWindow.set_visible(true)
	$ModuleWindow.module_selected = of_module

func _open_dock_window(of_module: Node3D):
	$DockWindow.set_visible(true)
	$DockWindow.module_selected = of_module
