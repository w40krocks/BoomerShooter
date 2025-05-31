extends Area3D
class_name Relocator

#the health taken fron the player when relocating
@export var RelocateCost : float

func _ready() -> void:
	body_entered.connect(Entered)

func Entered(body : Node3D):
	if body is PlayerCharacter:
		body.Reposition()
