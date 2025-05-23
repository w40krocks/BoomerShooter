extends BaseItem
class_name AmmoItem


@export var AmmoType : int


func Pickup(Enteredbody : Node3D):
	if CanBodyPickup(Enteredbody):
		if PlayerHasRoom(Enteredbody.find_child("WeaponManager")):
			Enteredbody.find_child("WeaponManager").AmmoUpdate(AmmoType, ItemAmount)
			Delete()

func PlayerHasRoom(Inventory : WeaponManager):
	if Inventory.AmmoCount["Current" + str(AmmoType)] >= Inventory.AmmoCount["Max" + str(AmmoType)]:
		return false
	else:
		return true
		
func _ready() -> void:
	PlayAnimation("Default")
