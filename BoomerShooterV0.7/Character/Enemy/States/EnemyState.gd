extends State
class_name EnemyState

@onready var Enemy : BaseEnemy = get_parent().get_parent()


func CheckIfDead():
	if Enemy.Health > 0:
		return false
	else: 
		return true
