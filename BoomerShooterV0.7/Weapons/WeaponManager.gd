extends Node3D
class_name WeaponManager

@onready var AmmoLabel : Label= get_parent().find_child("Ammo Label")

@export var StartingWeapon : BaseWeapon
var CurrentWeapon : BaseWeapon

var Counter : int
var isSwitching : bool



@export var WeaponsInventory : Dictionary = {
	#IsCurrentlyInUse
}

@export var AmmoCount : Dictionary = {
	#NoAmmo
	"Current0" : 10,
	"Max0" : 10,
	#bullet
	"Current1" : 10,
	"Max1" : 200,
	#shotgun shells
	"Current2" : 4,
	"Max2" : 50,
	#bombs
	"Current3" : 0,
	"Max3" : 10,
}

func InventoryCheck():
	for i in get_child_count():
		if get_child(i) is BaseWeapon:
			WeaponsInventory.get_or_add(get_child(i).name, false)
			get_child(i).Exited.connect(SwitchOver)

func SwitchCurrentWeapon(SwappedWeapon : BaseWeapon, NewWeapon : BaseWeapon):
	WeaponsInventory.set(SwappedWeapon.name, false)

	SwappedWeapon.Exit()
	CurrentWeapon = NewWeapon


func UpdateInventory(NewWeapon : BaseWeapon):
	WeaponsInventory.get_or_add(NewWeapon.name, false)
	var temp
	for i in get_child_count():
		if WeaponsInventory[get_child(i).name] == true:
			temp = get_child(i)
	SwitchCurrentWeapon(temp,NewWeapon)

func FindInInventory(ItemName : String):
	if WeaponsInventory.get(ItemName) != null:
		return true
	else:
		return false

func _ready() -> void:
	isSwitching = false
	InventoryCheck()
	WeaponsInventory[StartingWeapon.name] = true
	StartingWeapon.Enter()
	CurrentWeapon = StartingWeapon


func SwitchOver():
	print("SwitchOver ran")
	WeaponsInventory.set(CurrentWeapon.name, true)
	CurrentWeapon.Exited.connect(SwitchOver)
	CurrentWeapon.Enter()

func CounterCycling():
	if Counter < 0:
		Counter = get_child_count() -1
	elif Counter == get_child_count():
		Counter = 0

func WeaponSelect():
	if Input.is_action_just_pressed("SelectUp"):
		Counter += 1
	elif Input.is_action_just_pressed("SelectDown"):
		Counter -= 1
	CounterCycling()
	if get_child(Counter) != null:
		SwitchCurrentWeapon(CurrentWeapon, get_child(Counter))

func AmmoUpdate(AmmoToChange, AmmoAddedAmount):
	AmmoCount["Current"+ str(AmmoToChange)] += AmmoAddedAmount
	if AmmoCount["Current"+ str(AmmoToChange)] > AmmoCount["Max"+ str(AmmoToChange)]:
		AmmoCount["Current"+ str(AmmoToChange)] = AmmoCount["Max"+ str(AmmoToChange)]

func _process(delta: float) -> void:
	if isSwitching == false and Input.is_action_just_pressed("SelectUp") or Input.is_action_just_pressed("SelectDown"):
		WeaponSelect()
	
	AmmoLabel.text = str(AmmoCount["Current" + str(CurrentWeapon.AmmoType)])
