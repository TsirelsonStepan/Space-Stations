extends Button

var highlight_color = Color(0.0, 1.0, 0.0, 0.5)
var highlight_material = preload("res://materials/dock_material.tres")
var module_names = ["module"]
var module_objects = {}

func _ready():
	for i in module_names:
		module_objects[i] = load("res://objects/" + i + ".blend")

func _on_pressed():
	Global.placing_mode = Global.modes.MODULE
	Global.control._on_build_button_pressed()
	highlight_material.set_albedo(highlight_color)
	Global.builder.instance = module_objects[name].instantiate()
	Global.builder.instance.get_child(0).set_transparency(0.5)
	Global.builder.instance.name = name
	Global.builder.add_child(Global.builder.instance)
	
	Global.builder._on_build_choosen()
