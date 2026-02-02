extends Node

var module_window: Control
var top_bar: Control
var blueprint_panel: Control
func _ready() -> void:
	module_window = get_tree().get_root().get_node("Origin/CanvasLayer/UI/ModuleWindow")
	top_bar = get_tree().get_root().get_node("Origin/CanvasLayer/UI/TopBar")
	blueprint_panel = get_tree().get_root().get_node("Origin/CanvasLayer/UI/BlueprintPanel")
