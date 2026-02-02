extends Button

var highlight_color = Color(1.0, 0.5, 1.0, 0.5)
var highlight_material = preload("res://materials/highlight_material.tres")
var dock_scene = preload("res://objects/dock.blend")

func _on_pressed():
	Global.placing_mode = Global.modes.DOCK
	%Control._on_build_button_pressed()
	highlight_material.set_albedo(highlight_color)
	%Builder.instance = dock_scene.instantiate()
	%Builder.instance.get_child(0).set_transparency(0.5)
	%Builder.instance.name = "dock"
	%Builder.add_child(%Builder.instance)
	
	%Builder._on_build_choosen()
