extends RayWeapon
class_name Shotgun

@export var KnockbackAmount : float
var temp
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	temp = KnockbackAmount


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if WeaponManage.WeaponsInventory[name]:
		if Owner.is_on_floor():
			temp = KnockbackAmount
	
		if AttackCheck("Attack") and not Owner.is_on_floor():
			Owner.velocity.x += Owner.transform.basis.z.x * temp
			Owner.velocity.z += Owner.transform.basis.z.z * temp
			Owner.velocity.y += Owner.find_child("PlayerCam").transform.basis.z.y * temp
			Owner.Momentum = Owner.velocity
			temp /= 2
