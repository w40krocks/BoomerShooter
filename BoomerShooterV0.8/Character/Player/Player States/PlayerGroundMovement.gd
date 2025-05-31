extends PlayerMovement
class_name PlayerGroundMovement
func Enter():
	pass

func Update(delta):
	if not Player.is_on_floor():
		Transitioned.emit(self,"PlayerAirMovement")
		#Switch to Air Movement

func Exit():
	pass

func PhysicsUpdate(_delta : float):
	if Input.is_action_just_pressed("Jump"):
			Player.velocity.y = MoveSpeed / 2
	
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (Player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		Player.velocity.x += direction.x * MoveSpeed 
		Player.velocity.z += direction.z * MoveSpeed 
		Player.velocity = Player.velocity.limit_length(MaxSpeed)
		Player.Momentum = Player.velocity
	else:
		if Player.Momentum.x != 0 or Player.Momentum.z != 0:
			#applies friction to decelerate the player
			Player.Momentum.x *= 0.9
			Player.Momentum.z *= 0.9
		
		Player.velocity.x = move_toward(Player.velocity.x, Player.Momentum.x,MoveSpeed)
		Player.velocity.z = move_toward(Player.velocity.z, Player.Momentum.z, MoveSpeed)
		
		
