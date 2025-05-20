extends Node3D
class_name WeaponManager

@export var WeaponsInventory : Dictionary = {
	#IsCurrentlyInUse
	"Pistol" : false,
	"Shotgun" : true,
	"LMG" : true
}

@export var AmmoCount : Dictionary = {
	#NoAmmo
	"Current0" : 0,
	"Max0" : 0,
	#bullet
	"Current1" : 4,
	"Max1" : 10,
	#shotgun shells
	"Current2" : 50,
	"Max2" : 50,
	#bombs
	"Current3" : 0,
	"Max3" : 0,
}

func InventoryCheck():
	for i in get_child_count():
		WeaponsInventory.get_or_add(get_child(i).name, false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InventoryCheck()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in get_child_count():
		if WeaponsInventory.get(get_child(i).name) == null:
			WeaponsInventory.get_or_add(get_child(i).name, false)

func SwitchWeapon(NewWeapon : BaseWeapon):
	pass
