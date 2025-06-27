extends BaseEnemyState
class_name GrassRaptorLeapAttack

var LeapPoint : Vector3
var HasHitTarget : bool
func Enter():
	Self.Animator.play("Leap")
	LeapPoint = (Self.Target.global_position - Self.global_position).normalized()
	Self.AttackArea.monitoring = true
	Self.IdleTimer.start(1)
	if not Self.is_on_floor():
		Self.velocity.y = 2

func PhysicsUpdate(delta):
	Self.velocity.z = LeapPoint.z * Self.CharacterStat.MoveSpeed * 1.2
	Self.velocity.x = LeapPoint.x * Self.CharacterStat.MoveSpeed * 1.2
	Self.move_and_slide()

func Exit():
	Self.AttackArea.monitoring = false

func TimerStopped():
	Transitioned.emit(self,"EnemyChase")
