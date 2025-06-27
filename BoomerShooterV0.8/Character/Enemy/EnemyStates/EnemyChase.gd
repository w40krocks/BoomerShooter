extends BaseEnemyState
class_name EnemyChase

var CanSwitch : bool

func Enter():
	Self.Animator.play("Walk")
	CanSwitch = false
	Self.IdleTimer.start(randf_range(0.75,1.25))

func  PhysicsUpdate(delta):
	if Self.global_position.distance_to(Self.Target.global_position) <= Self.CharacterStat.MeleeAttackDistance:
		Transitioned.emit(self,"GrassRaptorBite")
	elif Self.is_on_floor():
		Chase(delta)
	if CanSwitch == true and Self.global_position.distance_to(Self.Target.global_position) <= Self.CharacterStat.RangedAttackDistance:
		Transitioned.emit(self,"GrassRaptorLeapAttack")

func Chase(delta):
	var ChasePos : Vector3 = Self.Target.global_position
	Self.NavAgent.target_position = Self.Target.global_position
	var DirectionToTarget = (Self.NavAgent.get_next_path_position() - Self.global_position).normalized()
	
	Self.velocity = DirectionToTarget * Self.CharacterStat.MoveSpeed
	Self.look_at(Vector3(Self.NavAgent.get_next_path_position().x,Self.position.y,Self.NavAgent.get_next_path_position().z))
	Self.move_and_slide()

func TimerStopped():
	CanSwitch = true
