extends Area3D
class_name LevelArea

@export var RelocateNode : Node3D
func _ready() -> void:
	body_entered.connect(Entered)

func Entered(body :Node3D):
	if body is PlayerCharacter:
		body.CharacterStat.LastVisitedArea = self
