extends BaseCharacter
class_name PlayerCharacter

@onready var IsAttacking : bool = false

@export var LastVisitedArea : LevelArea ##stores the last level area entered, this is used for the relocation function

@onready var Animator : AnimationPlayer = $AnimationPlayer

var Momentum : Vector3

@export var MaxAirSpeed := 30 ##defines the maximum speed a player can reach midair
@export var MaxGroundSpeed := 16 ##defines the maximum speed a player can reach on the ground
@onready var GroundSlamming := false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		PauseSwitch()
	
	if Input.is_action_just_pressed("Debug Button"):
		Reposition()
	
func _physics_process(delta: float) -> void:
	if GroundSlamming:
			if is_on_floor():
				Animator.play("GroundSlam")
				GroundSlamming = false
				
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JumpSpeed 
	if Engine.time_scale == 1:
		Movement()
	
	if Input.is_action_just_pressed("Down"):
		if not is_on_floor():
			GroundSlam()

	move_and_slide()

func HealthChange(HealthChange : float):
	print(CurrentHealth)
	CurrentHealth += HealthChange
	
	if CurrentHealth >= MaxHealth:
		CurrentHealth = MaxHealth
	if CurrentHealth <= 0:
		Death()
	print(CurrentHealth)


func Death():
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
			velocity.x += direction.x * MoveSpeed 
			velocity.z += direction.z * MoveSpeed 
			velocity = velocity.limit_length(MaxGroundSpeed)
		else:
			velocity.x += direction.x * (MoveSpeed*0.1)
			velocity.z += direction.z * (MoveSpeed*0.1)
			velocity = velocity.limit_length(MaxAirSpeed)
		Momentum = velocity
	else:
		
		if Momentum.x != 0 or Momentum.z != 0:
			#applies friction to decelerate the player
			if is_on_floor():
				Momentum *= 0.85
			else:
				Momentum *= 0.97
			
			if Momentum.x < 0.01 and Momentum.x > -0.01:
				Momentum.x = 0
			if Momentum.z < 0.01 and Momentum.z > -0.01:
				Momentum.z = 0
		velocity.x = move_toward(velocity.x, Momentum.x, MoveSpeed)
		velocity.z = move_toward(velocity.z, Momentum.z, MoveSpeed)

func GroundSlam(): ## multiplies gravity applied to the player and resets the players momentum, and sets the GroundSlamming variable to true
	GroundSlamming = true
	velocity = Vector3(0,get_gravity().y * 2,0)
	Momentum = Vector3(0,0,0)

func Reposition(): ## resets player momentum and repositions player to the relocate position of the last visited level area
	Momentum = Vector3(0,0,0)
	if LastVisitedArea:
		if LastVisitedArea.RelocateNode:
			position = LastVisitedArea.RelocateNode.global_position
