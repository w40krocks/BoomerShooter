extends RayWeapon
class_name Pistol

@onready var PistolWhip : Area3D = find_child("PistolWhip")



func Update(delta : float):
	if AttackCheck("Attack"):
		pass
	else:
		AltAttack()

func AltAttack():
	if WeaponAnimator.current_animation == "Alt Attack":
		if Input.is_action_pressed("Alt Attack"):
			PistolWhip.monitoring = true
			if WeaponAnimator.speed_scale < 8:
				WeaponAnimator.speed_scale += 0.02
		else:
			PistolWhip.monitoring = false
			WeaponAnimator.speed_scale = 1
			if HasAmmoToFire():
				Manager.HeldAmmo[str(AmmoType)+"-CurrentAmmo"] -= MinAmmoConsume
				WeaponAnimator.play("Attack")
				Attack(MinDamage + WeaponAnimator.speed_scale /2,MaxDamage *WeaponAnimator.speed_scale /2)
			else:
				WeaponAnimator.play("RESET")
	else:
		if Input.is_action_just_pressed("Alt Attack"):
			WeaponAnimator.play("Alt Attack")

func WhipContact(body : Node3D):
	var temp = Vector3(-Manager.Player.transform.basis.z)
	temp.y = 0.1
	if body.is_in_group("Launchable"):
		if body is BaseCharacter:
			print("made contact with basecharacter")
			body.velocity += temp * WeaponAnimator.speed_scale * 5
			body.HealthChange(-1 *WeaponAnimator.speed_scale)
			
		if body is RigidBody3D:
			body.apply_force(temp * WeaponAnimator.speed_scale * 10)
