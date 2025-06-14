extends RayWeapon
class_name Shotgun

@export var KnockbackAmount : float
@onready var temp : float = 0

func Update(delta : float):
	pass

func PhysicsUpdate(delta : float):
	if Manager.Player.is_on_floor():
			temp = KnockbackAmount
	if AttackCheck("Attack"): 
		if not Manager.Player.is_on_floor():
			ShotgunKickBack()

func ShotgunKickBack():
	Manager.Player.velocity.x += Manager.Player.transform.basis.z.x * temp
	Manager.Player.velocity.z += Manager.Player.transform.basis.z.z * temp
	Manager.Player.velocity.y += Manager.Player.find_child("PlayerCam").transform.basis.z.y * temp
	Manager.Player.Momentum = Manager.Player.velocity
	temp /= 2
