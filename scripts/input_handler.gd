extends Node

func _process(_delta: float) -> void:
	if Planner.current_preview:
		if Input.is_action_pressed("rotate_module_left"):
			Planner._rotate_preview(-10.0)
		if Input.is_action_pressed("rotate_module_right"):
			Planner._rotate_preview(10.0)
		if Input.is_action_just_pressed("exit_construction_mode"):
			Planner._cancel_selection()
