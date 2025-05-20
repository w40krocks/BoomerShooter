extends Character
class_name BaseEnemy

var Targets : Array = [Player]


@onready var MeleeRay : RayCast3D = find_child("MeleeAttack")
@onready var RangedRay : RayCast3D = find_child("RangedAttack")
@onready var NavigationAgent : NavigationAgent3D = find_child("NavAgent")

@export_subgroup("Melee Attack", "M")
@export var MRaycastXScale : float
@export var MRaycastYScale : float
@export var MRaycastZTarget : float
@export var MeleeDamage : float
@export var MeleeAttackDistance : float

@export_subgroup("Ranged Attack", "R")
@export var RRaycastXScale : float
@export var RRaycastYScale : float
@export var RRaycastZTarget : float
@export var RangedAttackDistance : float


#Sprite Stuff
@export_file var SpriteSheet : String

@export var SpriteSheetSize : Vector2
@onready var EnemySprite : Sprite3D = find_child("Sprite")
@onready var AnimationTimer : Timer = find_child("AnimationTimer")
var SpriteCoords : Vector2

#Sprite Stuff
@export_subgroup("SpriteSheetBoundaries", "Sprite")

@export var SpriteIdleMinPos : int
@export var SpriteIdleMaxPos : int 

@export var SpriteMoveMinPos : int
@export var SpriteMoveMaxPos : int 

@export var SpriteAttackMinPos : int
@export var SpriteAttackMaxPos : int 

@export var SpriteDeathMinPos : int
@export var SpriteDeathMaxPos : int
var SpriteHframe : int
#Sprite Stuff

#Search Stuff
@onready var ObstructionCheck : RayCast3D = find_child("ObstructionCheck")
@export_range(0,1) var ConeOfVision : float
@export var SearchDistance : float
@export var AwarenessZone : float
#Search Stuff

#Rotational Stuff
var TargetVector : Vector2
var SelfVector : Vector2
#Rotational Stuff

#Chase Stuff
var TargetPos : Vector2

#Attack Stuff

func SearchForTarget(Target,RotationalDistance : float):
	var ReturnValue := false
	if position.distance_to(Target.position) < AwarenessZone:
		ReturnValue = true
		#TargetFound
	elif position.distance_to(Target.position) < SearchDistance and GetRotationalDistance(Target) > ConeOfVision:
		#check for obstruction
		ReturnValue = IsTargetUnobstructed(Target)
	
				
	return ReturnValue

func IsTargetUnobstructed(Target):
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

#gets the rotational distance between the enemy and target
func GetRotationalDistance(Target):
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


func SetSprite(RotationalDistanceToTarget,Target):
	#show front sprite
	var RotationalDistance = rotation_degrees.y - Target.rotation_degrees.y
	if RotationalDistanceToTarget >=0.75:
		EnemySprite.rotation_degrees.y = 0
		SpriteCoords.y = 0 
		
	#show right sprite
	elif RotationalDistanceToTarget < 0.75 and RotationalDistanceToTarget > -0.75:
		if RotationalDistance < -45 and RotationalDistance > -135:
			SpriteCoords.y = 2
			EnemySprite.rotation_degrees.y = -90
	
		#show left sprite
		elif RotationalDistance > 45 and RotationalDistance < 135:
			SpriteCoords.y = 1
			EnemySprite.rotation_degrees.y = 90
		

	#show back sprite
	elif RotationalDistanceToTarget < -0.75:
		SpriteCoords.y = 3
		EnemySprite.rotation_degrees.y = 180
	#set sprite coords

func _ready() -> void:
	EnemySprite.hframes = SpriteSheetSize.x
	EnemySprite.vframes = SpriteSheetSize.y
	EnemySprite.texture = load(SpriteSheet)
	Targets.insert(1,get_parent().find_child("Player"))
	SetRays(MeleeRay,MRaycastXScale,MRaycastYScale,MRaycastZTarget)


func _process(delta: float) -> void:

	if Health > 0:
		SetSprite(GetRotationalDistance(Targets[1]),Targets[1])
	EnemySprite.frame_coords = SpriteCoords
	

func _physics_process(delta: float) -> void:
	if Health >0:
		if not is_on_floor():
			velocity += get_gravity() * delta
	
		move_and_slide()


func MoveAnimation(MinFrame:int,MaxFrame:int):
	SpriteHframe += 1
	if SpriteHframe < MinFrame or SpriteHframe > MaxFrame:
		SpriteHframe = MinFrame
	SpriteCoords.x = SpriteHframe
	#means it has looped
	if SpriteHframe ==MaxFrame:
		return true
	else: 
		return false


func SetRays(Ray : RayCast3D, RayXscale: float ,RayYscale : float ,RayZTarget : float):
	Ray.scale.x = RayXscale
	Ray.scale.y = RayYscale
	Ray.target_position.z = -(RayZTarget - position.z)
