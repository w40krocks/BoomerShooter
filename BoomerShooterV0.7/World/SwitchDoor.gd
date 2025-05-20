extends Node3D
class_name Door

@onready var isOpening := false
@export var OpenPos : Vector3

func SwitchPressed(delta : float):
	isOpening = true
	OpenPos =Vector3(position.x,position.y+5,position.z)

func _physics_process(delta: float) -> void:
	if isOpening:
		position =position.move_toward(OpenPos,delta*2)

		
