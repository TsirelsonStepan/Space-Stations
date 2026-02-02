extends Node

enum state{CONSTRUCTION, ON_HOLD, OPERATING}

var blueprints_data : Dictionary
var structure_data : StructureData
var storage_data : StorageData

func _ready() -> void:
	_load_blueprints_data()
	_load_structure_data()
	_load_storage_data()

const blueprints_data_json_path = "res://Data/blueprints_data.json"
func _load_blueprints_data() -> void:
	var json_string = FileAccess.open(blueprints_data_json_path, FileAccess.READ).get_as_text()
	blueprints_data = JSON.parse_string(json_string)

func _load_structure_data() -> void:
	if ResourceLoader.exists("user://structure_data_save.tres"):
		structure_data = ResourceLoader.load("user://structure_data_save.tres") as StructureData
	else:
		structure_data = ResourceLoader.load("user://starting_structure_data_save.tres") as StructureData

func _load_storage_data() -> void:
	if ResourceLoader.exists("user://storage_data_save.tres"):
		storage_data = ResourceLoader.load("user://storage_data_save.tres") as StorageData
	else:
		storage_data = ResourceLoader.load("user://starting_storage_data_save.tres") as StorageData

func _save() -> void:
	ResourceSaver.save(structure_data, "user://structure_data_save.tres")
	ResourceSaver.save(storage_data, "user://storage_data_save.tres")
