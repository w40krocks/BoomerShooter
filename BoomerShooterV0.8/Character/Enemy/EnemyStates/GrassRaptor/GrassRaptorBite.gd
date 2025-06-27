extends BaseEnemyState
class_name GrassRaptorBite

func Enter():
	Self.Animator.play("Attack")
	Self.AttackArea.monitoring = true
	Self.IdleTimer.start(Self.Animator.current_animation_length)

func Exit():
	Self.AttackArea.monitoring = false

func TimerStopped():
	Transitioned.emit(self,"EnemyChase")
