extends Area3D
class_name Switch

var CanBePressed: bool
@onready var HasBeenPressed := false

signal JustPressed




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !HasBeenPressed:
		if CanBePressed:
			for i in get_overlapping_bodies().size():
				if get_overlapping_bodies()[i] is Player:
					if Input.is_action_just_pressed("Interact"):
						JustPressed.emit()
						$Button/AnimationPlayer.play("Pressed")
						HasBeenPressed = true



func _ButtonCanBePressed(bodyEntered: Node3D) -> void:
	print("go fuck yourself")
	if bodyEntered is Player:
		CanBePressed = true


func _on_body_exited(bodyExited: Node3D) -> void:
	if bodyExited is Player:
		CanBePressed = true
