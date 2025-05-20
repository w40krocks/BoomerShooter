extends RayCast3D

var Damage : float
var WeaponTimer : float
var Ammo : int

var WeaponTexture : String
var HFrames
var Xframe = 1

var WeaponInUse : bool
var LabelColour 
var WeaponDisplaySprite
var MaxAmmo : int

@onready var WeaponSprite = $Control/Sprite2D
@onready var WeaponDisplay = $Display/Sprite2D
@onready var Spotlight = $SpotLight3D
@onready var Player = get_parent().get_parent().get_parent().get_parent()
@onready var GunSmoke = "res://Weapon/GunSmoke.tscn"
func _ready() -> void:
	WeaponInUse = true
	self.get_parent()._WeaponReset(self)


func _process(delta: float) -> void:
		if Ammo > MaxAmmo:
			Ammo = MaxAmmo
		$Label.text = str(Ammo)
		if Input.is_action_just_pressed("Attack"):
			_Attack()
		
		if self.is_colliding():
			if self.get_collider() != null:
				if self.get_collider().name.substr(0,5) == "Enemy":
					Player.get_child(2).get_child(0).modulate =Color(1,0,0)
				else:
					Player.get_child(2).get_child(0).modulate =Color(1,1,1)

func _SetWeaponSprite():
	WeaponSprite.texture = load(WeaponTexture)
	WeaponSprite.hframes = HFrames
	var WeaponSpriteSize = WeaponSprite.texture.get_size()
	get_child(0).size = WeaponSpriteSize
	WeaponSprite.offset.x = -(WeaponSpriteSize.x/WeaponSprite.hframes)/2
	WeaponSprite.offset.y = -WeaponSpriteSize.y
	WeaponSprite.scale = Vector2(8,8)
	
	WeaponDisplay.texture = load(WeaponDisplaySprite)
	WeaponDisplay.scale = Vector2(8,8)
	WeaponDisplay.offset.y =  -WeaponDisplay.texture.get_size().y
	$Label.position.x = WeaponDisplay.texture.get_size().x
	$Label.modulate = Color(LabelColour[0],LabelColour[1],LabelColour[2])

	

	
	

func _SetWeaponInfo(WeaponInfo : Array):
	#WeaponInfo[RayScaleX,RayScaleY,RayTposZ,Damage,WeaponTimer,Ammo,WeaponTexture]
	self.scale.x = WeaponInfo[0]
	self.scale.y = WeaponInfo[1]
	self.target_position.z = -WeaponInfo[2]
	Damage = WeaponInfo[3]
	Ammo = WeaponInfo[4]
	WeaponTexture = WeaponInfo[5]
	HFrames =  WeaponInfo[6]
	WeaponTimer = WeaponInfo[7]
	WeaponDisplaySprite = WeaponInfo[8]
	$WeaponCooldown.wait_time = WeaponTimer
	LabelColour = WeaponInfo[9]
	MaxAmmo = WeaponInfo[10]

func _Attack():
	if Ammo > 0 and WeaponSprite.frame_coords == Vector2i(0,0) and WeaponInUse == true:
		$WeaponCooldown.start()
		WeaponSprite.frame_coords = Vector2(1,0)
		$OmniLight3D.show()
		Ammo -= 1
		Player.IsAttacking = true
		if self.is_colliding():
			if self.get_collider().name.substr(0,5) == "Enemy":
				self.get_collider()._HealthChange(-Damage)
				
			var temp = load(GunSmoke).instantiate()
			temp.position = self.get_collision_point()
			Player.get_parent().add_child(temp)


func _on_weapon_cooldown_timeout() -> void:
	if  WeaponSprite.frame_coords.x != (HFrames - 1):
		$OmniLight3D.hide()
		Xframe += 1
		WeaponSprite.frame_coords.x = Xframe
		$WeaponCooldown.start()
	else:
		Xframe = 0
		WeaponSprite.frame_coords.x = Xframe
		Player.IsAttacking = false

func _HideWeapon():
	get_child(0).hide()
	get_child(0).get_child(0).hide()
	get_child(2).hide()
	get_child(3).hide()
	WeaponInUse = false
func _ShowWeapon():
	get_child(0).show()
	get_child(0).get_child(0).show()
	get_child(2).show()
	get_child(3).show()
	WeaponInUse = true
