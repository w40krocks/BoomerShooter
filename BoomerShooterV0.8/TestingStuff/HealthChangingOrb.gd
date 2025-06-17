extends Area3D
class_name HealthChangeOrb

@export var HealthChange : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(Entered)


func Entered(body : Node3D):
	if body is BaseCharacter:
		body.HealthChange(HealthChange)
