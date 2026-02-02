extends Node

func _ready():
	Global.builder = %Builder
	Global.camera = %Camera
	Global.control = %Control
	
	var station_data_structure
	if ResourceLoader.exists("user://save.tres"):
		station_data_structure = ResourceLoader.load("user://save.tres") as StationData
		for key in station_data_structure.modules_data.keys():
			var module_data = station_data_structure.station[key]
			var module = load("res://module_scenes/" + module_data.physical_type + ".tscn").instantiate()
			module.name = module_data.physical_type + "_" + str(key)
			module.data_structure_id = key
			get_tree().get_root().get_node("Origin/StationHolder").add_child(module)
			module.global_position = module_data.global_position
			module.global_rotation = module_data.global_rotation
			for i in range(len(module_data.docks)):
				if module_data.docks[i] != -1:
					var dock = load("res://module_scenes/dock.tscn").instantiate()
					dock.name = "dock_" + str(key) + str(i)
					module.add_child(dock)
					var dock_transform = module.get_node("DockPlaces").get_child(i)
					dock.set_global_position(dock_transform.get_global_position())
					dock.set_global_rotation(dock_transform.get_global_rotation())
	else:
		station_data_structure = StationData.new()
		station_data_structure._add_module_to_structure($"../StationHolder/default-module_1")
	
	Global.builder.station_data_structure = station_data_structure
	
	queue_free()
