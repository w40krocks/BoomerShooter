extends Character
class_name Player

var Momentum : Vector3
@export var JumpSpeed : float 

@onready var MaxAirSpeed := 30
@onready var MaxGroundSpeed := 16




func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		PauseSwitch()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JumpSpeed
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if is_on_floor():
			if velocity.x > MaxGroundSpeed:
				velocity.x -= MaxGroundSpeed * delta*2
			elif velocity.x < -MaxGroundSpeed:
				velocity.x -= -MaxGroundSpeed * delta*2
			else: 
				velocity.x =GroundMove(direction.x,delta)

			if velocity.z > MaxGroundSpeed:
				velocity.z -= MaxGroundSpeed * delta*2
			elif velocity.z < -MaxGroundSpeed:
				velocity.z -= -MaxGroundSpeed * delta*2
			else:
				velocity.z = GroundMove(direction.z,delta)
		else:
			velocity.x += direction.x * (MoveSpeed*0.015) * delta
			velocity.z += direction.z * (MoveSpeed*0.015) * delta
			if velocity.x > MaxAirSpeed:
				velocity.x = MaxAirSpeed
			elif velocity.x < -MaxAirSpeed:
				velocity.x = -MaxAirSpeed
			if velocity.z > MaxAirSpeed:
				velocity.z = MaxAirSpeed
			elif velocity.z < -MaxAirSpeed:
				velocity.z = -MaxAirSpeed
		
		Momentum = velocity
	
	else:
		if Momentum.x != 0 or Momentum.z != 0:
			#applies friction to decelerate the player
			if is_on_floor():
				Momentum.x *= 0.9
				Momentum.z *= 0.9
			else:
				Momentum.x *= 0.99
				Momentum.z *= 0.99
		
		velocity.x = move_toward(velocity.x, Momentum.x,MoveSpeed)
		velocity.z = move_toward(velocity.z, Momentum.z, MoveSpeed)

	move_and_slide()

func PauseSwitch():
	if Engine.time_scale == 1:
		Engine.time_scale = 0
	else:
		Engine.time_scale = 1

func GroundMove(direction : float,delta : float):
	return direction * MoveSpeed * delta
