extends EnemyState
class_name EnemyMelee

func Enter():
	pass

func Exit():
	Enemy.AnimationTimer.stop()

func Update(_delta : float):
	if CheckIfDead():
		Transitioned.emit(self,"EnemyDeath")
	if Enemy.AnimationTimer.is_stopped():
		if Enemy.SpriteHframe == Enemy.SpriteAttackMaxPos:
			Attack()
			Transitioned.emit(self,"EnemyChase")
		else:
			Enemy.MoveAnimation(Enemy.SpriteAttackMinPos,Enemy.SpriteAttackMaxPos)
			Enemy.AnimationTimer.start()
	
	

func PhysicsUpdate(_delta : float):
	pass

func Attack():
	if Enemy.MeleeRay.is_colliding():
		if Enemy.MeleeRay.get_collider() is Character:
			Enemy.MeleeRay.get_collider().Health -= Enemy.MeleeDamage
