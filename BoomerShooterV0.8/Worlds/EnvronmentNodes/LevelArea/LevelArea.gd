extends Area3D
class_name LevelArea

@onready var RelocateNode : Node3D = find_child("Relocate pos")
var RelocatePosition : Vector3
func _ready() -> void:
	RelocatePosition = RelocateNode.global_position
	body_entered.connect(Entered)

func Entered(body :Node3D):
	if body is PlayerCharacter:
		print("area visited")
		body.LastVisitedArea = self
