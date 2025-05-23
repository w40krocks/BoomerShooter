extends RayWeapon
class_name LMG




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if IsInUse():
		AttackCheck("Attack")

		if IsAttacking("Attack") == 2:
			WeaponAni.play("RESET")
