extends Node3D

@onready var WeaponCooldown = $Node3D/WeaponCooldown
@onready var WeaponInfo = $DisplayPos/WeaponInfo
@onready var DisplayWeapon = $DisplayPos/DisplayWeapon
@onready var WeaponSprite = $WeaponPos/WeaponView
@onready var WeaponLight = $WeaponLight
@onready var Player = self.find_parent("Player")

@onready var SelectOption = load("res://Weapons/WeaponOption.tscn")
var WeaponSelect

#---SpriteInformation
var WeaponSpriteLocation : String
var HorizFrames : int
var CurrentAnimation : int
var WeaponScaleFactor : float
#---SpriteInformation

#---WeaponStats
var WeaponName : String
var AttackCooldown : float 
var MaxAmmo : int
var CurrentAmmo : int
var Damage : float
#---WeaponStats

#---InfoDisplay
var WeaponDisplaySprite : String
var DisplayWeaponScaleFactor : float
var PrimaryWeaponColour : Color
#---InfoDisplay

func SetSprite():
	WeaponSprite.texture = load(WeaponSpriteLocation)
	WeaponSprite.hframes = HorizFrames
	WeaponSprite.offset.y = -WeaponSprite.texture.get_size().y
	WeaponSprite.offset.x = -((WeaponSprite.texture.get_size().x /2)/HorizFrames)
	WeaponSprite.scale = Vector2(WeaponScaleFactor,WeaponScaleFactor)

func SetDisplay():
	WeaponInfo.scale = Vector2(DisplayWeaponScaleFactor/3,DisplayWeaponScaleFactor/3)
	WeaponInfo.position.y -= WeaponInfo.get_rect().size.y 
	DisplayWeapon.texture = load(WeaponDisplaySprite)
	DisplayWeapon.position.y -= DisplayWeapon.texture.get_size().y * DisplayWeaponScaleFactor
	DisplayWeapon.scale = Vector2(DisplayWeaponScaleFactor,DisplayWeaponScaleFactor)
	DisplayWeapon.modulate.a = 0.75
	WeaponInfo.modulate = PrimaryWeaponColour
	WeaponInfo.get_child(0).text = WeaponName

func WeaponAnimation():
	if CurrentAnimation == 0:
		WeaponKickback()
		MuzzleFlashTween()
	CurrentAnimation += 1
	if CurrentAnimation != HorizFrames:
		WeaponSprite.frame_coords.x = CurrentAnimation
		WeaponCooldown.start()
		Player.IsAttacking = true
	else:
		Player.IsAttacking = false
		CurrentAnimation = 0
		WeaponSprite.frame_coords.x = CurrentAnimation

func AddSelectOption():
	var temp = SelectOption.instantiate()
	temp._setOptionInfo(WeaponName,CurrentAmmo,WeaponDisplaySprite, DisplayWeaponScaleFactor)
	temp.name = WeaponName
	find_parent("Player").find_child("WeaponSelect").add_child(temp)

func FindSelectOption():
	WeaponSelect = find_parent("Player").find_child("UI").find_child("WeaponSelect")
	for i in WeaponSelect.get_child_count():
		if WeaponSelect.get_child(i).name == WeaponName:
			WeaponSelect = WeaponSelect.get_child(i)

func HideWeapon():
	hide()
	for i in get_child_count():
		if get_child(i) is Timer or get_child(i) is OmniLight3D:
			pass
		else:
			get_child(i).hide()

func ShowWeapon():
	show()
	for i in get_child_count():
		if get_child(i) is Timer or get_child(i) is OmniLight3D:
			pass
		else:
			get_child(i).show()

func MuzzleFlashTween():
	WeaponLight.show()
	var tween := create_tween()
	tween.EaseType.EASE_OUT_IN
	tween.tween_property(WeaponLight,"omni_range",5,AttackCooldown/2)
	tween.chain().tween_property(WeaponLight,"omni_range",0,0.5*HorizFrames)
	tween.play()

func WeaponKickback():
	var tween1 := create_tween()
	var nod = Node3D.new()
	#tween1.EaseType.EASE_OUT_IN

	tween1.tween_property($Model,"rotation_degrees",Vector3(10,0,0),0.1)
	tween1.chain().tween_property($Model,"rotation_degrees",Vector3(0,0,0),0.1)
	tween1.play()
	nod.rotation_degrees.y += 90
