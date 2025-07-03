extends Node3D
class_name WeaponManager

@export var IntialWeapon : BaseWeapon

@onready var Player = find_parent("Player")
@onready var WeaponChoice : int
@export var WeaponInventory : Node3D

@export var Inventory : WeaponINV


func _ready() -> void:
	Inventory = Inventory.duplicate()
	InventoryCheck()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func InventoryCheck():
	for child in WeaponInventory.get_children():
		if child is BaseWeapon:
			if child != Inventory.CurrentWeapon:
				child.hide()
			Inventory.Weapons[child.name] = child
			
			if !child.Transitioned.is_connected(_WeaponsTransition):
				child.Transitioned.connect(_WeaponsTransition)
	
	if IntialWeapon:
		IntialWeapon.Enter()
		Inventory.CurrentWeapon = IntialWeapon
		Inventory.CurrentWeaponName = IntialWeapon.name
	else:
		WeaponInventory.get_child(0).Enter()
		Inventory.CurrentWeapon = WeaponInventory.get_child(0)

func LoadSavedInventory():
	Inventory.Weapons


func _process(delta: float) -> void:
	if Inventory.CurrentWeapon:
		Inventory.CurrentWeapon.Update(delta)
	else:
		Inventory.CurrentWeapon = find_child(Inventory.CurrentWeaponName)
	WeaponSwitching()
	
	if !Inventory.CurrentWeapon:
		Inventory.CurrentWeapon = IntialWeapon
	
func _physics_process(delta: float) -> void:
	if Inventory.CurrentWeapon:
		Inventory.CurrentWeapon.PhysicsUpdate(delta)
	
func _WeaponsTransition(Weapon, NewWeaponName):
	if Weapon != Inventory.CurrentWeapon:
		return
	
	var NewWeapon = Inventory.Weapons.get(NewWeaponName)
	if not NewWeapon:
		return
	
	if Inventory.CurrentWeapon:
		Inventory.CurrentWeapon.Exit()
	NewWeapon.Enter()
	NewWeapon.PreviousWeapon = Inventory.CurrentWeapon
	Inventory.CurrentWeapon = NewWeapon

func WeaponSwitching():
	if Input:
		if Input.is_action_just_pressed("ScrollUp"):
			WeaponChoice += 1
		elif Input.is_action_just_pressed("ScrollDown"):
			WeaponChoice -= 1
		if WeaponChoice < 0:
			WeaponChoice = WeaponInventory.get_child_count() -1
		elif WeaponChoice > WeaponInventory.get_child_count() -1:
			WeaponChoice = 0
		if Inventory.CurrentWeapon:
			
			if Inventory.CurrentWeapon.WeaponAnimator.is_playing() and Inventory.CurrentWeapon.WeaponAnimator.current_animation != "RESET":
				pass
			
			elif WeaponInventory.get_child(WeaponChoice) != Inventory.CurrentWeapon:
				_WeaponsTransition(Inventory.CurrentWeapon, WeaponInventory.get_child(WeaponChoice).name)
		
		

func AddAmmo(AmmoToAdd: int, AmmoType : int):
	Inventory.HeldAmmo[str(AmmoType)+"-CurrentAmmo"] += AmmoToAdd
	if Inventory.HeldAmmo[str(AmmoType)+"-CurrentAmmo"] > Inventory.HeldAmmo[str(AmmoType)+"-MaxAmmo"]:
		Inventory.HeldAmmo[str(AmmoType)+"-CurrentAmmo"] = Inventory.HeldAmmo[str(AmmoType)+"-MaxAmmo"]
