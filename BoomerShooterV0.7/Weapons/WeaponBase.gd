extends Node3D
class_name BaseWeapon

@export var MinAmmoConsume : int
@export var AmmoType : int #1-Bullet, 2-Shells, 3-Rockets
@export var FireRate : float
@export var ShotAngleRandomRange : Vector2
@export var Damage : float


@onready var WeaponModel = find_child("Weapon Model")
@onready var WeaponTimer = find_child("WeaponCoolDown")
@onready var WeaponAni : AnimationPlayer = find_child("Weapon Animation Player")
@onready var Owner = find_parent("Player")
@onready var WeaponManage = find_parent("WeaponManager")
@onready var WeaponVisualsParent = find_child("Weapon Visuals")




func HasEnoughAmmoToShoot():
	if WeaponManage.WeaponsInventory[name]:
		if WeaponManage.AmmoCount["Current" +str(AmmoType)] < MinAmmoConsume:
			#does not have enough Ammo to shoot
			return false
		else:
			#has enough Ammo to shoot
			return true

func CanShoot(AttackName : String):
	var ReturningValue := false
	if HasEnoughAmmoToShoot():
		if WeaponAni.current_animation != AttackName:
			ReturningValue = true
	return ReturningValue

func IsAttacking(AttackName : String):
	if Input.is_action_just_pressed(AttackName):
		#single press
		return 0
	elif Input.is_action_pressed(AttackName):
		#held down
		return 1
	else:
		return 2

func Enter():
	WeaponManage.WeaponsInventory[name] = true
	WeaponAni.play("Enter")

func Exit():
	WeaponManage.WeaponsInventory[name] = false
	WeaponAni.play("Exit")
