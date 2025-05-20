extends "res://Weapons/RayCast/RayWeapon.gd"

func _ready() -> void:
	WeaponSpriteLocation = "res://Weapons/RayCast/Pistol/PistolV3SpriteSheet.png"
	HorizFrames = 3
	CurrentAnimation = 0
	WeaponScaleFactor = 8
	WeaponName = "Pistol"
	AttackCooldown = 0.25
	MaxAmmo = 75
	CurrentAmmo = 10
	Damage = 10
	
	WeaponDisplaySprite = "res://Weapons/RayCast/Pistol/PistolV3Pickup.png"
	DisplayWeaponScaleFactor = 5
	PrimaryWeaponColour = Color(0.0313,0.6431,0.0784)
	
	Ztarget = 30
	Xscale = 1
	Yscale = 1
	
	SetSprite()
	SetDisplay()
	SetRays()
	WeaponCooldown.wait_time = AttackCooldown
	AddSelectOption()
	FindSelectOption()

func _process(_delta: float) -> void:
	
	if CurrentAmmo > MaxAmmo:
		CurrentAmmo = MaxAmmo
	WeaponInfo.get_child(1).text = str(CurrentAmmo)
	WeaponSelect.get_child(1).text = str(CurrentAmmo)
	if visible:
		if Input.is_action_just_pressed("Attack") and WeaponCooldown.is_stopped() and CurrentAmmo > 0:
			Attack()
