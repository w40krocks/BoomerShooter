extends BaseCharacter
class_name PlayerCharacter

@onready var IsAttacking : bool = false

@onready var Animator : AnimationPlayer = $AnimationPlayer

@onready var GroundSlamming : bool = false
var Momentum : Vector3

func _ready():
	CharacterStat.CharacterName = self.name

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		PauseSwitch()
	
	if Input.is_action_just_pressed("Debug Button"):
		Reposition()
		load("res://TestingStuff/testResource.tres").Num += 1
		print(load("res://TestingStuff/testResource.tres").Num)
	
func _physics_process(delta: float) -> void:
	if GroundSlamming:
			if is_on_floor():
				Animator.play("GroundSlam")
				GroundSlamming = false
				
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = CharacterStat.JumpSpeed 
	if Engine.time_scale == 1:
		Movement()
	
	if Input.is_action_just_pressed("Down"):
		if not is_on_floor():
			GroundSlam()

	move_and_slide()

func HealthChange(HealthChange : float):
	CharacterStat.CurrentHealth += HealthChange
	
	if CharacterStat.CurrentHealth >= CharacterStat.MaxHealth:
		CharacterStat.CurrentHealth = CharacterStat.MaxHealth
	if CharacterStat.CurrentHealth <= 0:
		Death()

func Death(): ##NOTE-not implemented
	pass

func PauseSwitch(): ## sets timescale to 0 if unpaused, sets timescale to 1 if paused
	if Engine.time_scale == 1:
		Engine.time_scale = 0
	else:
		Engine.time_scale = 1

func Movement(): ##handles the acceleration, deceleration and limiting character speed based on whether the player is in the air or not
	
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if is_on_floor():
			velocity.x += direction.x * CharacterStat.MoveSpeed 
			velocity.z += direction.z * CharacterStat.MoveSpeed 
			velocity = velocity.limit_length(CharacterStat.MaxGroundSpeed)
		else:
			velocity.x += direction.x * (CharacterStat.MoveSpeed*0.1)
			velocity.z += direction.z * (CharacterStat.MoveSpeed*0.1)
			velocity = velocity.limit_length(CharacterStat.MaxAirSpeed)
		Momentum = velocity
	else:
		
		if Momentum.x != 0 or Momentum.z != 0:
			#applies friction to decelerate the player
			if is_on_floor():
				Momentum *= 0.85
			else:
				Momentum *= 0.97
			
			if abs(Momentum.x) < 0.01:
				Momentum.x = 0
			if abs(Momentum.z) < 0.01:
				Momentum.z = 0
		velocity.x = move_toward(velocity.x, Momentum.x, CharacterStat.MoveSpeed)
		velocity.z = move_toward(velocity.z, Momentum.z, CharacterStat.MoveSpeed)

func GroundSlam(): ## multiplies gravity applied to the player and resets the players momentum, and sets the GroundSlamming variable to true
	GroundSlamming = true
	velocity = Vector3(0,get_gravity().y * 2,0)
	Momentum = Vector3(0,0,0)

func Reposition(): ## resets player momentum and repositions player to the relocate position of the last visited level area
	Momentum = Vector3(0,0,0)
	if CharacterStat.LastVisitedArea:
		if CharacterStat.LastVisitedArea.RelocateNode:
			position = CharacterStat.LastVisitedArea.RelocateNode.global_position
