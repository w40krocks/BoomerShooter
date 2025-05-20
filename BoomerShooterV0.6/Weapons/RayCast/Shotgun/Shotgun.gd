extends "res://Weapons/RayCast/RayWeapon.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WeaponSpriteLocation = "res://Weapons/RayCast/Shotgun/ShotgunV3SpriteSheet.png"
	HorizFrames = 3
	CurrentAnimation = 0
	WeaponScaleFactor = 8
	WeaponName = "Shotgun"
	AttackCooldown = 0.75
	MaxAmmo = 40
	CurrentAmmo = 6
	Damage = 35
	
	WeaponDisplaySprite = "res://Weapons/RayCast/Shotgun/ShotgunV3Pickup.png"
	DisplayWeaponScaleFactor = 5
	PrimaryWeaponColour = Color(0.8470,0.0784,0.2039)
	
	Ztarget = 15
	Xscale = 5
	Yscale = 5
	
	SetSprite()
	SetDisplay()
	SetRays()
	WeaponCooldown.wait_time = AttackCooldown
	AddSelectOption()
	FindSelectOption()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if CurrentAmmo > MaxAmmo:
		CurrentAmmo = MaxAmmo
	WeaponInfo.get_child(1).text = str(CurrentAmmo)
	WeaponSelect.get_child(1).text = str(CurrentAmmo)
	if visible:
		if Input.is_action_just_pressed("Attack") and WeaponCooldown.is_stopped() and CurrentAmmo > 0:
			Attack()
