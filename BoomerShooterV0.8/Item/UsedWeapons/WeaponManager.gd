extends Node3D
class_name WeaponManager

@export var IntialWeapon : BaseWeapon

@onready var Player = self.get_parent().get_parent()
@onready var WeaponChoice : int
@export var WeaponInventory : Node3D
var CurrentWeapon : BaseWeapon
var Weapons : Dictionary = {}

@export var HeldAmmo : Dictionary = { ## holds the current and maximum amount of ammo held by the player
	"0-CurrentAmmo" : 0, # test
	"0-MaxAmmo" : 0,
	
	"1-CurrentAmmo" : 0, # bullet
	"1-MaxAmmo" : 0,
	
	"2-CurrentAmmo" : 0, # shell
	"2-MaxAmmo" : 0,
	
	"3-CurrentAmmo" : 0, # bomb
	"3-MaxAmmo" : 0
}

func _ready() -> void:
	for child in WeaponInventory.get_children():
		if child is BaseWeapon:
			if child != CurrentWeapon:
				child.hide()
			Weapons[child.name] = child
			child.Transitioned.connect(_WeaponsTransition)
	
	if IntialWeapon:
		IntialWeapon.Enter()
		CurrentWeapon = IntialWeapon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CurrentWeapon:
		CurrentWeapon.Update(delta)
	WeaponSwitching()
	
func _physics_process(delta: float) -> void:
	if CurrentWeapon:
		CurrentWeapon.PhysicsUpdate(delta)
	
func _WeaponsTransition(Weapon, NewWeaponName):
	if Weapon != CurrentWeapon:
		return
	
	var NewWeapon = Weapons.get(NewWeaponName)
	if not NewWeapon:
		return
	
	if CurrentWeapon:
		CurrentWeapon.Exit()
	NewWeapon.Enter()
	NewWeapon.PreviousWeapon = CurrentWeapon
	CurrentWeapon = NewWeapon

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
		
		if CurrentWeapon.WeaponAnimator.is_playing() and CurrentWeapon.WeaponAnimator.current_animation != "RESET":
			pass
		
		elif WeaponInventory.get_child(WeaponChoice) != CurrentWeapon:
				_WeaponsTransition(CurrentWeapon, WeaponInventory.get_child(WeaponChoice).name)
	
	
