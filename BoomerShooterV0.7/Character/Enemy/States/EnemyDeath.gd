extends EnemyState
class_name EnemyDeath

var AnimationFinished : bool

func Enter():
	AnimationFinished = false
	Enemy.velocity -= Enemy.velocity
	Enemy.AnimationTimer.start()
	Enemy.SpriteCoords.y = 4
	Enemy.SpriteHframe = 0

func Update(delta):
	if not AnimationFinished:
		if Enemy.AnimationTimer.is_stopped():
			AnimationFinished = Enemy.MoveAnimation(Enemy.SpriteDeathMinPos,Enemy.SpriteDeathMaxPos)
			Enemy.AnimationTimer.start()
			if AnimationFinished:
				Enemy.find_child("CollisionShape3D").disabled = true
				Enemy.EnemySprite.billboard =BaseMaterial3D.BILLBOARD_FIXED_Y
