extends Camera3D
class_name PlayerCam

@export var Sensitivity = 0.01


func _unhandled_input(event: InputEvent) -> void:
	if Engine.time_scale == 1:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if event is InputEventMouseMotion:
			get_parent().rotate_y(-event.relative.x * Sensitivity)
			rotate_x(-event.relative.y * Sensitivity)
			rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
	elif Engine.time_scale == 0 :
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
