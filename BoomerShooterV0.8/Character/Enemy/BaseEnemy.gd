extends BaseCharacter
class_name BaseEnemy

@export_category("Enemy Stats")
@export var AwarenessZone : float ##the distance around the enemy, where the player will be spotted immediately
@export var SearchDistance : float ##the distance from the enemy where the player can be spotted
@export var ConeOfVision : float ##the rotational distance from the front enemy, determines how wide or narrow the enemies distance
var TargetVector : Vector2 ##the Targets horizontal position
var SelfVector : Vector2 ##the Enemies horizontal position

@export_category("Target Information")
@export var Target : BaseCharacter ##the target the enemy will look for and attack

@export_category("In Scene Stuff")
@export var ObstructionCheck : RayCast3D ##raycast used to check if the enemy has an unobstructed view to the target
@export var EnemyModel : Node3D  ##the EnemyModel

func HealthChange(HealthChange : float): ## Adds the entered amount of health to the current health of the enemy
	print(HealthChange)
	if HealthChange > 0 and !is_on_floor():
		HealthChange *= 1.5
	CurrentHealth += HealthChange
	
	if CurrentHealth >= MaxHealth:
		CurrentHealth = MaxHealth
	if CurrentHealth <= 0:
		Death()

func Death(): ##runs when the player runs out of health
	pass

func Giblet(): ##runs if the enemy has under a certain amount of health, destroys the model and spawns a particle
	pass

func SearchForTarget(Target,RotationalDistance : float): ##checks if the enemy can spot the target
	var ReturnValue := false
	if position.distance_to(Target.position) < AwarenessZone:
		ReturnValue = true
		#TargetFound
	elif position.distance_to(Target.position) < SearchDistance and RotationalDistance > ConeOfVision:
		#check for obstruction
		ReturnValue = IsTargetUnobstructed(Target)
	return ReturnValue

func IsTargetUnobstructed(Target): ##returns boolean value based on whether the enemy has an unobstructed view of the target
	var ReturnValue := false
	#sets target position to Target position
	ObstructionCheck.target_position = Target.position - position
	if ObstructionCheck.rotation != ObstructionCheck.rotation - rotation:
		ObstructionCheck.rotation = Vector3(0,0,0) - rotation
	if ObstructionCheck.get_collider() != null:
			if ObstructionCheck.get_collider() == Target:
				#TargetFound
				ReturnValue = true
	return ReturnValue

	#removes all of the enemies position information as the raycast will inherit all position
	#information as it is the enemies child

func GetRotationalDistance(Target): ##gets the rotational distance between the enemy and target
	#gets the front position of the enemy, in this cause -Z
	var SelfForward = -transform.basis.z
	#gets the horizontal position of the Target
	TargetVector.x =(Target.global_position.x)
	TargetVector.y =(Target.global_position.z)
	#gets the horizontal position of the enemy
	SelfVector.x =(global_position.x)
	SelfVector.y =(global_position.z) 
	#determines the direction of the Target from the enemy
	var DirectionToTarget = SelfVector.direction_to(TargetVector)
	
	#normalises the enemies forward position
	var nSelf = Vector2(SelfForward.x, SelfForward.z).normalized()
	#gets the dot result (NOTE not entirely sure how this works, but the outcomes is it determines
	#the rotational distance from the enemies forward position)
	var dotResult = DirectionToTarget.dot(nSelf)
	return(dotResult)
