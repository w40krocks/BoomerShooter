extends Node3D 
class_name BaseWeapon

enum AmmoTypes {
	TEST, ##purely for test purposes
	BULLETS, ## Used by the Pistol and LMG
	SHELLS, ## Used by the shotgun
	BOMBS ## Used by the Rocket Launcher
	}

@export_category("Weapon Stats")
@export var MinDamage : float ## the Minimum amount of damage the Weapon will deal per hit
@export var MaxDamage : float ## the Maximum amount of damage the Weapon will deal per hit
@export var AmmoType : AmmoTypes ## the ammo type consumed by the Weapon
@export var MinAmmoConsume : int ## the minimum amount of ammo used per shot

@export_category("Weapon Scene Resources")
@export var WeaponVisuals : Node3D ## the parent node of all weapon visuals
@export var WeaponAnimator : AnimationPlayer ## the animation player used by all weapon actions

@export_category("Weapon Manager")
@export var Manager : WeaponManager


signal Transitioned ## Called when switching between Weapons
var PreviousState : BaseWeapon 

func Enter(): ## Ran when the weapon is first switched to
	WeaponAnimator.play("RESET")
	self.show()

func Exit(): ## Ran when the weapon is being switched out
	WeaponAnimator.play("RESET")
	self.hide()

func Update(_delta : float): ## Ran every frame when it is the active weapon
	pass

func PhysicsUpdate(_delta : float):## Ran every frame when it is the active weapon
	pass

func AttackInputCheck(): ##Checks if the Player has fired once, is holding down the fire button or is not firing
	if Input.is_action_just_pressed("Attack"):
		return 0 # single fire
	elif Input.is_action_pressed("Attack"):
		return 1 # refiring
	else:
		return 2 # not firing
func HasAmmoToFire(): ##checks if the weapon manager holds the needed amount of ammo to fire
	if Manager.HeldAmmo[str(AmmoType)+"CurrentAmmo"] >= MinAmmoConsume:
		Manager.HeldAmmo[str(AmmoType)+"CurrentAmmo"] - MinAmmoConsume
		return true
	else:
		return false
