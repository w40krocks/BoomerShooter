extends Area3D
class_name LevelArea

@onready var RelocateNode : Node3D = find_child("Relocate pos")
func _ready() -> void:
	body_entered.connect(Entered)

func Entered(body :Node3D):
	if body is PlayerCharacter:
		body.LastVisitedArea = self
