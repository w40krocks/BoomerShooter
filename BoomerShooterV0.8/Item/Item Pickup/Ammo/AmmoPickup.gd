extends BaseItem
class_name AmmoPickup

@export var AmmoR := AmmoResource.new()
@export_category("AmmoInfo")

func _ready() -> void:
	PlayIdleAnimation()
	ConnectSignal()

func AttemptPickUp(body : PlayerCharacter):
	return AttemptAmmoAdd( body.find_child("WeaponManager"))

func AttemptAmmoAdd(WeaponManage : WeaponManager):
	if WeaponManage.Inventory.HeldAmmo[str(AmmoR.AmmoChoice)+"-CurrentAmmo"] < WeaponManage.Inventory.HeldAmmo[str(AmmoR.AmmoChoice)+"-MaxAmmo"]:
		WeaponManage.AddAmmo(ConsumableAmount, AmmoR.AmmoChoice)
		return true
	else:
		return false
