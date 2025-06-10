extends RayWeapon
class_name Shotgun

@export var KnockbackAmount : float
@export var ExplosiveShell : PackedScene
@onready var temp : float = 0

func Update(delta : float):
	pass

func PhysicsUpdate(delta : float):
	if Manager.Player.is_on_floor():
			temp = KnockbackAmount
	if AttackCheck("Attack"): 
		if not Manager.Player.is_on_floor():
			ShotgunKickBack()
	elif Input.is_action_just_pressed("Alt Attack"):
		
		if CanAttack("Alt Attack") and CanAttack("Attack"):
			AltAttack()

func ShotgunKickBack():
	Manager.Player.velocity.x += Manager.Player.transform.basis.z.x * temp
	Manager.Player.velocity.z += Manager.Player.transform.basis.z.z * temp
	Manager.Player.velocity.y += Manager.Player.find_child("PlayerCam").transform.basis.z.y * temp
	Manager.Player.Momentum = Manager.Player.velocity
	temp /= 2

func AltAttack():
	WeaponAnimator.play("Alt Attack")
	var temp = ExplosiveShell.instantiate()
	var tempVal : Vector3
	temp.rotation = temp.rotation + Manager.Player.rotation
	temp.rotation.y = temp.rotation.y + Manager.Player.find_child("PlayerCam").rotation.y
	tempVal = Manager.Player.transform.basis.z
	tempVal.y = Manager.Player.find_child("PlayerCam").transform.basis.z.y
	temp.apply_force(Manager.Player.velocity - tempVal *50)
	temp.position = EndOfBarrel.global_position
	get_tree().current_scene.add_child(temp)
