extends Node

const path_to_json = "res://StartingConditions/starting_conditions.json"

var string_to_enum = {
	"ON_HOLD" : Global.state.ON_HOLD,
	"OPERATING" : Global.state.OPERATING,
	"CONSTRUCTION" : Global.state.CONSTRUCTION
}

func _parse() -> void:
	var dict = JSON.parse_string(FileAccess.open(path_to_json, FileAccess.READ).get_as_text())
	var structure = StructureData.new()
	for key in dict["structure_data"]["modules_data"].keys():
		structure.modules_data[int(key)] = ModuleData.new()
		structure.modules_data[int(key)].uri = dict["structure_data"]["modules_data"][key][0]
		structure.modules_data[int(key)].specialization = dict["structure_data"]["modules_data"][key][1]
		structure.modules_data[int(key)].physical_type = dict["structure_data"]["modules_data"][key][2]
		structure.modules_data[int(key)].state = string_to_enum[dict["structure_data"]["modules_data"][key][3]]
		
	for key in dict["structure_data"]["modules_transforms"].keys():
		var vec = dict["structure_data"]["modules_transforms"][key]
		structure.modules_transforms[int(key)] = [Vector3(vec[0][0], vec[0][1], vec[0][2]), Vector3(vec[1][0], vec[1][1], vec[1][2])]
	
	var storage = StorageData.new()
	storage.resources = dict["storage_data"]["resources"]
	storage.limits = dict["storage_data"]["limits"]
	
	Global.structure_data = structure
	Global.storage_data = storage
	ResourceSaver.save(structure, "user://starting_structure_data_save.tres")
	ResourceSaver.save(storage, "user://starting_storage_data_save.tres")
