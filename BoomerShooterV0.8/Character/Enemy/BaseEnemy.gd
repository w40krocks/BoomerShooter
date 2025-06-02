extends BaseCharacter
class_name BaseEnemy


@export_category("Target Information")
@export var Target : BaseCharacter

@export_category("In Scene Stuff")
@export var ObstructionCheck : RayCast3D

func HealthChange(HealthChange : float):
	pass

func Death():
	pass

func GetRotaionalDistanceToTarget(Target):
	pass

func SearchForTarget(Target):
	pass
