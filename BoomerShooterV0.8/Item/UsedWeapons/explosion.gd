extends Node3D

@export var Damage : float

func _ready() -> void:
	$AnimationPlayer.play("Explosion")

func ExplosionEntered(body : Node3D):
	if body is BaseCharacter:
		body.HealthChange(Damage)

func Delete():
	self.queue_free()
