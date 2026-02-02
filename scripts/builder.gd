extends Node3D

var instance: Node3D

var station_data_structure: StationData

func _on_build_choosen():
	instance.set_visible(false)

func _place_instance(collider: StaticBody3D, parent_module: Node3D):
	var to_place : Node3D = load("res://module_scenes/" + instance.name + ".tscn").instantiate()
	add_child(to_place)
	to_place.set_global_position(instance.get_global_position())
	to_place.set_global_rotation(instance.get_global_rotation())
	if Global.placing_mode == Global.modes.MODULE:
		to_place.name = "module_"
		to_place.name += station_data_structure._add_module_to_structure(to_place)
		print(to_place.name)
		to_place.reparent($"../StationHolder")
	elif Global.placing_mode == Global.modes.DOCK:
		to_place.name = "dock_"
		to_place.name += ""#station_data_structure._add_dock_to_module(to_place)
		print(to_place.name)
		to_place.reparent(parent_module)
		
	ResourceSaver.save(station_data_structure, "user://save.tres")
	_exit_placing_mode()

func _place_preview(body: StaticBody3D):
	if Global.placing_mode == Global.modes.NONE: return
	instance.set_rotation(body.get_global_rotation())
	var height = instance.get_child(0).get_aabb().size.y / 2.0
	var pos = body.get_global_position() - body.get_parent().get_global_position()
	if Global.placing_mode == Global.modes.MODULE: pos = body.get_parent().get_global_position() - body.get_parent().get_parent().get_global_position()
	var k = height / pos.length()
	instance.set_position(body.get_global_position() + pos * k)
	instance.set_visible(true)

func _hide_preview():
	if Global.placing_mode == Global.modes.NONE: return
	instance.set_visible(false)

func _exit_placing_mode():
	if Global.placing_mode != Global.modes.NONE:
		Global.placing_mode = Global.modes.NONE
		instance.queue_free()
		load("res://materials/dock_material.tres").set_albedo(Color(1.0, 1.0, 1.0, 1.0))
		load("res://materials/highlight_material.tres").set_albedo(Color.TRANSPARENT)
