extends CharacterBody3D

var MoveSpeed : float
var FieldOfView
var Health : float
var MaxHealth : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MaxHealth = Health


func _HealthChange(HealthChange):
	Health = Health + HealthChange
