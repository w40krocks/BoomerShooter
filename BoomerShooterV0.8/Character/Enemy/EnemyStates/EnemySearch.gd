extends BaseEnemyState
class_name EnemySearch

func Enter():
	pass

func Exit():
	pass

func Update(_delta : float):
	
	if Self.SearchForTarget(Self.Target,Self.GetRotationalDistance(Self.Target)):
		print("within view")
		if Self.IsTargetUnobstructed(Self.Target):
			Transitioned.emit(self,"EnemyChase")

func PhysicsUpdate(_delta : float):
	pass
