extends Node

const modules_scenes_folder = "res://Assets/ModulesScenes/"
var currenly_selected_module_type: String
var current_preview: Node3D
var is_visible : bool

func _select_module(module_type: String) -> void:
	if current_preview: _cancel_selection()
	currenly_selected_module_type = module_type
	current_preview = load(modules_scenes_folder + currenly_selected_module_type + "_construction.tscn").instantiate()
	get_tree().get_root().get_node("Origin/StationHolder").add_child(current_preview)
	current_preview.set_visible(false)
	HighlightToggle._toggle_connectors(module_type, true)

func _cancel_selection() -> void:
	HighlightToggle._toggle_connectors(currenly_selected_module_type, false)
	#current_preview.queue_free()
	current_preview = null
	currenly_selected_module_type = ""

func _place_preview(body: StaticBody3D) -> void:
	current_preview.set_rotation(body.get_global_rotation())
	var height = Global.blueprints_data[currenly_selected_module_type].size[1] / 2.0
	var pos = body.get_global_position() - body.get_parent().get_global_position()
	var k = height / pos.length()
	current_preview.set_position((body.get_global_position() * 100).round() / 100.0 + (pos * k * 100).round() / 100.0)
	current_preview.set_visible(true)
	is_visible = true

func _rotate_preview(degrees: float) -> void:
	current_preview.rotate_object_local(Vector3.UP, degrees / PI)

func _hide_preview() -> void:
	current_preview.set_visible(false)
	is_visible = false

const path_to_builder_scene = "res://builder.tscn"
func _place_project() -> void:
	var builder_node = load(path_to_builder_scene).instantiate()
	Global.structure_data._add_module_to_structure(current_preview, currenly_selected_module_type)
	current_preview.name = currenly_selected_module_type + "-"
	current_preview.add_child(builder_node)
	current_preview.set_process_mode(Node.PROCESS_MODE_INHERIT)
	
	_cancel_selection()

func _finish_project(module: Node3D) -> void:
	var finished_module = load(modules_scenes_folder + module.get_meta("ModuleData").physical_type + ".tscn").instantiate()
	finished_module.set_process_mode(Node.PROCESS_MODE_INHERIT)
	finished_module.name = module.get_meta("ModuleData").physical_type
	#finished_module.set_meta("ModuleData", module.get_meta("ModuleData"))
	add_child(finished_module)
	finished_module.set_position(module.get_global_position())
	finished_module.set_rotation(module.get_global_rotation())
	Global.structure_data._add_module_to_structure(finished_module, module.get_meta("ModuleData").physical_type)
