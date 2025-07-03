extends Area3D
class_name SecretArea

@onready var HasBeenVisited := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(Entered)

func Entered(body: Node3D):
	if body is PlayerCharacter:
		HasBeenVisited = true
