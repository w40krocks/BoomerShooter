extends BaseItem
class_name WeaponItem

@export_file var HeldWeapon 
@export var WeaponName : String
var temp

func Pickup(Enteredbody : Node3D):
	if CanBodyPickup(Enteredbody):
		if PlayerHasRoom(Enteredbody.find_child("WeaponManager")):
			Enteredbody.find_child("WeaponManager").add_child(temp)
			Enteredbody.find_child("WeaponManager").UpdateInventory(temp)
			Enteredbody.find_child("WeaponManager").Counter = Enteredbody.find_child("WeaponManager").get_child_count() -1
			Delete()

func PlayerHasRoom(Inventory : WeaponManager):
	if Inventory.FindInInventory(name):
		return false
	else:
		var t = "Current" + str(temp.AmmoType)
		Inventory.AmmoCount[t] += ItemAmount
		return true
		
func _ready() -> void:
	temp  = load(HeldWeapon).instantiate()
	temp.name = WeaponName
	temp.visible = false
	PlayAnimation("Default")
