extends Node

var completion_percentage : float
var consumed_resources : Dictionary

func _ready() -> void:
	_allocate_resources()
	_allocate_time()
	mesh = $"../Mesh/Main" as MeshInstance3D
	step_size = (100.0 / mesh.get_blend_shape_count())
	current_step = 0

func _allocate_time() -> void:
	var length_of_construction = Global.blueprints_data[get_parent().get_meta("ModuleData").physical_type].time
	$ConstructionTimer.connect("timeout", _construction_step_timeout)
	$ConstructionTimer.start(length_of_construction / 100.0)

func _allocate_resources() -> void:
	var required_resources = Global.blueprints_data[get_parent().get_meta("ModuleData").physical_type].cost
	for item in required_resources.keys():
		if Global.storage_data._decrease(item, required_resources[item]) == "OK":
			consumed_resources[item] = required_resources[item]
		else:
			Global.structure_data._update_module_state(get_parent(), Global.state.ON_HOLD)
			print("not enough resources")
			return
	Global.structure_data._update_module_state(get_parent(), Global.state.CONSTRUCTION)

var current_step
var step_size
var mesh
func _construction_step_timeout() -> void:
	if get_parent().get_meta("ModuleData").state == Global.state.CONSTRUCTION:
		completion_percentage += 0.1
		print(str(int(completion_percentage)) + "%")
	if completion_percentage >= 100:
		_deploy()

func _deploy():
	print(get_parent().get_global_position())
	Planner._finish_project(get_parent())
	Global.structure_data._remove_module_from_structure(get_parent())
	get_parent().queue_free()
