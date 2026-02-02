extends Camera3D

const speed : float = 1.0
var center : Vector3 = Vector3.ZERO

func _process(_delta: float):
	if Input.is_action_pressed("mouse_3"):
		var mouse_move = Input.get_last_mouse_velocity() / 6000.0
		var new_rotation = get_parent().rotation + Vector3(-mouse_move.y, -mouse_move.x, 0)
		new_rotation = new_rotation.clamp(Vector3(-PI/2, NAN, 0), Vector3(PI/2, NAN, 0))
		get_parent().set_rotation(new_rotation)
	if Input.is_action_just_pressed("zoom_in"): position.z -= 1
	if Input.is_action_just_pressed("zoom_out"): position.z += 1
	
	if get_parent().get_position() != center:
		var direction = (center - get_parent().get_position()).normalized()
		get_parent().position += direction * speed
		if ((get_parent().position - center).length() < (direction * speed).length()): get_parent().set_position(center)

func _move_center(new_center: Vector3):
	center = new_center
