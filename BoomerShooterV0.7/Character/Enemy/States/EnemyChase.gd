extends EnemyState
class_name EnemyChase
func Enter():
	pass

func Exit():
	Enemy.velocity = Vector3(0,0,0)
	Enemy.AnimationTimer.stop()

func Update(delta):
	if CheckIfDead():
		Transitioned.emit(self,"EnemyDeath")
	if Enemy.AnimationTimer.is_stopped():
		Enemy.MoveAnimation(Enemy.SpriteMoveMinPos,Enemy.SpriteMoveMaxPos)
		Enemy.AnimationTimer.start()

	if Enemy.MeleeAttackDistance > Enemy.position.distance_to(Enemy.Targets[1].global_position):
		Transitioned.emit(self,"EnemyMelee")
func PhysicsUpdate(delta):
	Chase(delta)

func Chase(delta):
	var ChasePos : Vector3 = Enemy.Targets[1].global_position
	
	Enemy.NavigationAgent.target_position = Enemy.Targets[1].global_position
	var DirectionToTarget = (Enemy.NavigationAgent.get_next_path_position() - Enemy.global_position).normalized()
	
	Enemy.velocity = DirectionToTarget * Enemy.MoveSpeed * delta*2
	Enemy.look_at(Vector3(Enemy.NavigationAgent.get_next_path_position().x,Enemy.position.y,Enemy.NavigationAgent.get_next_path_position().z))
	Enemy.move_and_slide()
