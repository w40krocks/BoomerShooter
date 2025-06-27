extends BaseEnemyState
class_name EnemyDeath

func Enter():
	Self.Animator.play("RESET")
	Self.Animator.play("Death")
	Self.CharacterStat.IsAlive = false

func Exit():
	Self.Animator.play("RESET")
	Self.CharacterStat.IsAlive = true

func Update(_delta : float):
	pass

func PhysicsUpdate(_delta : float):
	pass
