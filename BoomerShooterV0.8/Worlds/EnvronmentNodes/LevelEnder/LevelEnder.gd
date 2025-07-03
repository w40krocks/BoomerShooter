extends Area3D
class_name LevelEnder

@export var EndingCam : Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(Entered)

func Entered(body: Node3D):
	if body is PlayerCharacter:
		body.find_child("UI").hide()
		Engine.time_scale = 0
		EndingCam.make_current()
		EndingCam.get_child(0).show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		EndingCam.get_child(0).Funky()
