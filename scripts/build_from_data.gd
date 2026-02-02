extends Node

const modules_scenes_folder = "res://Assets/ModulesScenes/"

func _build() -> void:
	var structure = Global.structure_data
	for module_data_uri in structure.modules_data.keys():
		var data = structure.modules_data[module_data_uri] as ModuleData
		var module
		if data.state == Global.state.OPERATING:
			module = load(modules_scenes_folder + data.physical_type + ".tscn").instantiate()
		elif data.state == Global.state.CONSTRUCTION or data.state == Global.state.ON_HOLD:
			module = load(modules_scenes_folder + data.physical_type + "_construction.tscn").instantiate()
		module.set_process_mode(Node.PROCESS_MODE_INHERIT)
		module.name = data.physical_type + "_"
		module.set_meta("ModuleData", data)
		add_child(module)
		module.global_position = structure.modules_transforms[module_data_uri][0]
		module.global_rotation = structure.modules_transforms[module_data_uri][1]
		
		#add loop to set values of all modules with "storage" specialization to values from data
