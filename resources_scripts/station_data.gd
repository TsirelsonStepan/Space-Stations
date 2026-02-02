extends Resource
class_name StationData

@export var modules_data: Dictionary
@export var modules_positions: Dictionary
@export var docks_positions: Dictionary
@export var last_index: int

func _add_module_to_structure(module: Node3D):
	last_index += 1
	module.uri = "" + str(last_index)
	
	var new_module_data = ModuleData.new()
	new_module_data.physical_type = module.name.split("_")[0]
	for i in range(module.get_node("DockPlaces").get_child_count()): new_module_data.docks.append(-1)
	new_module_data.specialization = "none"
	modules_data[module.uri] = new_module_data
	
	modules_positions[module.uri] = [module.global_position, module.global_rotation]

func _add_dock_to_module(dock: Node3D):
	pass#modules_data[dock.get_parent().uri].docks[dock.get_index()] = 0
