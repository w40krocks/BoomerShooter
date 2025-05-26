extends CharacterBody3D
class_name BaseCharacter



@export_category("Movement")
@export var MoveSpeed : float
@export var JumpSpeed : float

@export_category("Health Info")
@export var CurrentHealth : float
@export var MaxHealth : float
@export var MaxOverHealth : float


func HealthChange(HealthChange : float):
	pass

func Death():
	pass
