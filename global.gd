extends Node

enum modes {NONE, DOCK, MODULE}

var placing_mode = modes.NONE

var camera: Camera3D
var builder: Node3D
var control: Control
