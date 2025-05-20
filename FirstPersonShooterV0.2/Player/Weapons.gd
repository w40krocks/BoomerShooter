extends Node2D

@onready var WeaponCast = $"../../WeaponCast"
@onready var Cooldown = $"../../../../../Cooldown"
@onready var WeaponChoice

@onready var Pistol = $Pistol
@onready var Shotgun = $Shotgun
@onready var Unarmed = $Unarmed

var CurrentRaycastDimension
var CurrentDamage
var CurrentCooldownTime
var CurrentWeaponName
var Cooldowncheck = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_WeaponSelect(1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot") and Cooldowncheck == false:
		_attack([CurrentRaycastDimension[0],CurrentRaycastDimension[1],CurrentRaycastDimension[2]], CurrentDamage, CurrentCooldownTime, CurrentWeaponName)
	if Input.is_action_just_pressed("Unhanded Select"):
		_WeaponSelect(1)
	if Input.is_action_just_pressed("Pistol Select"):
		_WeaponSelect(2)
	if Input.is_action_just_pressed("Shotgun Select"):
		_WeaponSelect(3)
	
func _attack(RaycastDimensions, Damage, CooldownTime, WeaponName):
	WeaponCast.scale.x = RaycastDimensions[0]
	WeaponCast.scale.y = RaycastDimensions[1]
	WeaponCast.target_position.z = RaycastDimensions[2]
	Cooldown.start()
	Cooldowncheck = true
	WeaponName.play("Shoot")
	$"../Face".play("Angry")
	if WeaponCast.is_colliding():
		print("shot hit!")
	

func _WeaponSelect(choice):
	#unhanded
	if choice == 1:
		#xyz
		CurrentRaycastDimension = [40,40,-2]
		CurrentDamage = 5
		Cooldown.wait_time = 1
		CurrentWeaponName = $Unarmed/Unarmed
		_resetWeapons()
		Unarmed.show()
		Cooldown.start()
		Cooldowncheck = true
	#pistol
	if choice == 2:
		CurrentRaycastDimension = [4,4,-12]
		CurrentDamage = 5
		Cooldown.wait_time = 0.3
		CurrentWeaponName = $Pistol/Pistol
		_resetWeapons()
		Pistol.show()
		
	#Shotgun
	if choice == 3:
		CurrentRaycastDimension = [8,8,-7]
		CurrentDamage = 5
		Cooldown.wait_time = 1
		CurrentWeaponName = $Shotgun/Shotgun
		_resetWeapons()
		Shotgun.show()

func _resetWeapons():
	Pistol.hide()
	Shotgun.hide()
	Unarmed.hide()

func CooldownOver():
	CurrentWeaponName.play("Idle")
	Cooldowncheck = false
	$"../Face".play("Idle")
