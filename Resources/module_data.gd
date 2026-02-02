extends Resource
class_name ModuleData

@export var uri: int
@export var specialization: String
@export var physical_type: String
@export var state: Global.state # for now just "CONSTRUCTION" and "OPERATING". Later can add "DAMAGED", etc

static func _construct(_uri: int, _specialization: String, _physical_type: String) -> ModuleData:
	var new_data = ModuleData.new()
	new_data.uri = _uri
	new_data.specialization = _specialization
	new_data.physical_type = _physical_type
	return new_data
