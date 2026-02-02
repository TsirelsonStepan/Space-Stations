extends Resource
class_name StructureData

@export var modules_data: Dictionary
@export var modules_transforms: Dictionary

func _add_module_to_structure(module: Node3D, type: String):
	var x = int(module.global_position.x * 1000) & 0xFFFFF
	var y = int(module.global_position.y * 1000) & 0xFFFFF
	var z = int(module.global_position.z * 1000) & 0xFFFFF
	var uri = (x << 40) | (y << 20) | z

	module.set_meta("ModuleData", ModuleData._construct(uri, "none", type))
	
	modules_data[uri] = module.get_meta("ModuleData")
	modules_transforms[uri] = [module.global_position, module.global_rotation]

func _remove_module_from_structure(module: Node3D):
	modules_data.erase(module.get_meta("ModuleData").uri)
	modules_transforms.erase(module.get_meta("ModuleData").uri)

func _update_module_state(module: Node3D, new_state: Global.state):
	var uri = module.get_meta("ModuleData").uri
	modules_data[uri].state = new_state
	module.get_meta("ModuleData").state = new_state
