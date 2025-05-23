extends Node3D
class_name Door

@onready var isOpening := false
@export var ConnectedButton : Switch


func _ready() -> void:
	ConnectedButton.JustPressed.connect(SwitchPressed)

func SwitchPressed():
	isOpening = true
	$AnimationPlayer.play("Open")
