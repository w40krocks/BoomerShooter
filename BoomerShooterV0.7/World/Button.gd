extends Area3D
class_name Switch

var CanBePressed: bool
@onready var HasBePressed := false

signal JustPressed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !HasBePressed:
		if CanBePressed:
			for i in get_overlapping_bodies().size():
				if get_overlapping_bodies()[i] is Player:
					if Input.is_action_just_pressed("Interact"):
						print("just pressed")
						JustPressed.emit(delta)
						HasBePressed = true



func _ButtonCanBePressed(bodyEntered: Node3D) -> void:
	if bodyEntered is Player:
		CanBePressed = true


func _on_body_exited(bodyExited: Node3D) -> void:
	if bodyExited is Player:
		CanBePressed = true
