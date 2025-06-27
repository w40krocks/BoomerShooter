extends BaseEnemyState
class_name GrassRaptorRetreat

var ValidPosFound : bool

func Enter():
	Self.Animator.play("Walk")
	Self.IdleTimer.start(randf_range(0.5,2))
	Self.IdleTimer.timeout.connect(TimerStopped)
	Self.NavAgent.target_position = Vector3(randf_range(Self.global_position.x - 20,Self.global_position.x + 20),0,randf_range(Self.global_position.z - 20,Self.global_position.z + 20))

func PhysicsUpdate(delta):
	var DirectionToTarget = (Self.NavAgent.get_next_path_position() - Self.global_position).normalized()
	Self.velocity = DirectionToTarget * Self.CharacterStat.MoveSpeed /2
	Self.look_at(Vector3(Self.NavAgent.get_next_path_position().x,Self.position.y,Self.NavAgent.get_next_path_position().z))
	Self.move_and_slide()

func Update(delta):
	pass

func TimerStopped():
	Transitioned.emit(self,"EnemyChase")
