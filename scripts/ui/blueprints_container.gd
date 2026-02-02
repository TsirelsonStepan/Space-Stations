extends Control

func _on_button_pressed() -> void:
	set_visible(!is_visible())

func _ready() -> void:
	for child in get_children():
		child.connect("pressed", Planner._select_module.bind(child.name))
