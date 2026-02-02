extends Control

func _ready() -> void:
	$SystemButton.connect("pressed", Global._save)
	#open small window with full screen panel blocking interactions with game
	#and smaller window in the center to select save, settings, exit, etc.
