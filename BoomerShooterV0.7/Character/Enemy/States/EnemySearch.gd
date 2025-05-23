extends EnemyState
class_name EnemySearch


func Enter():
	Enemy.SpriteCoords.x = 0
	if PreviousState is EnemyMelee:
		Enemy.look_at(Vector3(Enemy.Targets[1].position.x,Enemy.position.y,Enemy.Targets[1].position.z))

	
func Update(delta):
	
	
	if CheckIfDead():
		Transitioned.emit(self,"EnemyDeath")
	var TargetFound = Enemy.SearchForTarget(Enemy.Targets[0],Enemy.GetRotationalDistance(Enemy.Targets[0]))
	if TargetFound:
		#ChaseState
		Transitioned.emit(self,"EnemyChase")
		print("found")

	

func PhysicsUpdate(delta):
	pass

func Exit():
	pass
	
