extends BaseCharacter
class_name PlayerCharacter

@export var LastVisitedArea : LevelArea

@onready var Animator : AnimationPlayer = $AnimationPlayer

var Momentum : Vector3

@onready var MaxAirSpeed := 25
@onready var MaxGroundSpeed := 16
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
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	Movement()
	
	
	if Input.is_action_just_pressed("Down"):
		if not is_on_floor():
			GroundSlam()

	move_and_slide()

func PauseSwitch():
	if Engine.time_scale == 1:
		Engine.time_scale = 0
	else:
		Engine.time_scale = 1

func Movement():
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if is_on_floor():
			velocity.x = direction.x * MoveSpeed 
			velocity.z = direction.z * MoveSpeed 
			velocity = velocity.limit_length(MaxGroundSpeed)
		else:
			velocity.x += direction.x * (MoveSpeed*0.025)
			velocity.z += direction.z * (MoveSpeed*0.025)
			velocity = velocity.limit_length(MaxAirSpeed)
		Momentum = velocity
	
	else:
		if Momentum.x != 0 or Momentum.z != 0:
			#applies friction to decelerate the player
			if is_on_floor():
				Momentum.x *= 0.75
				Momentum.z *= 0.75
			else:
				Momentum.x *= 0.97
				Momentum.z *= 0.97
		velocity.x = move_toward(velocity.x, Momentum.x,MoveSpeed)
		velocity.z = move_toward(velocity.z, Momentum.z, MoveSpeed)

func GroundSlam():
	GroundSlamming = true
	velocity = Vector3(0,get_gravity().y * 2,0)
	Momentum = Vector3(0,0,0)

func Reposition():
	Momentum = Vector3(0,0,0)

	if LastVisitedArea.RelocatePosition:
		position = LastVisitedArea.RelocatePosition
