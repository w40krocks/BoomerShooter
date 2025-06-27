extends State
class_name BaseEnemyState
@export var Self : BaseEnemy

func _ready() -> void:
	Self.IdleTimer.timeout.connect(TimerStoppedRunCheck)

func Enter():
	pass

func Exit():
	pass

func Update(_delta : float):
	pass

func PhysicsUpdate(_delta : float):
	pass

func TimerStoppedRunCheck():
	if get_parent().CurrentState == self:
		TimerStopped()

func TimerStopped():
	pass
