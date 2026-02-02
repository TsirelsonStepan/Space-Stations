extends Node

var highlight_materials : Dictionary
const highlight_materials_folder = "res://Materials/Highlight/Connectors/"
const highlight_color = Color(1, 0, 1, 0.5)
const default_color = Color(1, 0, 1, 0)

var outline_material : StandardMaterial3D
const outline_material_path = "res://Materials/Highlight/outline_material.tres"
var outlined_module : Node3D

func _ready() -> void:
	var dir = DirAccess.open(highlight_materials_folder)
	var files = dir.get_files()
	for file in files:
		highlight_materials[file.split('.')[0]] = load(highlight_materials_folder + file)
	
	outline_material = load(outline_material_path) as StandardMaterial3D

func _toggle_connectors(module_type: String, state: bool) -> void:
	if state: highlight_materials[Global.blueprints_data[module_type].connector].set_albedo(highlight_color)
	else: highlight_materials[Global.blueprints_data[module_type].connector].set_albedo(default_color)

func _toggle_module(module_mesh: Node3D, state: bool) -> void:
	var mesh : MeshInstance3D = module_mesh.get_child(0)
	if state:
		if outlined_module: _toggle_module(outlined_module, false)
		outline_material.set_albedo(mesh.get_active_material(0).get_albedo())
		mesh.set_surface_override_material(0, outline_material)
		outlined_module = module_mesh
	else: mesh.set_surface_override_material(0, null)
