extends PlayerMovement
class_name PlayerAirMovement
func Enter():
	pass

func Update(delta):
	if Player.is_on_floor():
		Transitioned.emit(self, "PlayerGroundMovement")

func Exit():
	pass

func PhysicsUpdate(delta : float):
	
	
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (Player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		Player.velocity.x += direction.x * MoveSpeed 
		Player.velocity.z += direction.z * MoveSpeed 
		Player.velocity = Player.velocity.limit_length(MaxSpeed)
		Player.Momentum = Player.velocity
		Player.velocity += Player.get_gravity() * delta

	else:
		if Player.Momentum.x != 0 or Player.Momentum.z != 0:
			#applies friction to decelerate the player
			Player.Momentum.x *= 0.97
			Player.Momentum.z *= 0.97
		
		Player.velocity.x = move_toward(Player.velocity.x, Player.Momentum.x,MoveSpeed)
		Player.velocity.z = move_toward(Player.velocity.z, Player.Momentum.z, MoveSpeed)
		
	
