extends Node
class_name WeaponManager

@export var IntialWeapon : BaseWeapon

var CurrentWeapon : BaseWeapon
var Weapons : Dictionary = {}

var HeldAmmo : Dictionary = { ## holds the current and maximum amount of ammo held by the player
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
	for child in get_children():
		if child is BaseWeapon:
			Weapons[child.name] = child
			child.Transitioned.connect(_WeaponsTransition)
	
	if IntialWeapon:
		IntialWeapon.Enter()
		CurrentWeapon = IntialWeapon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CurrentWeapon:
		CurrentWeapon.Update(delta)
	
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
	NewWeapon.PreviousState = CurrentWeapon
	CurrentWeapon = NewWeapon
