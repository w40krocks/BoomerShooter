extends Container

@export_category("FaceStats")
@export var IdleFace : Array = [0,1,2]
@export var AngryFace : Array = [3,4,5]
@export var FaceCoords = Vector2(0,0)
#----FaceCoords

@export_category("InSceneInfo")
@export var FaceTimer : Timer
@export var FaceSprite : Sprite2D

@export var CurrentHealthLabel : Label
@export var HealthDividerLabel : Label
@export var MaxHealthLabel : Label

@export var CurrentAmmoLabel : Label
@export var AmmoDividerLabel : Label
@export var MaxAmmoLabel : Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void: 
	_FaceLocation()
	
	HealthLabelUpdate(CurrentHealthLabel, get_parent().Player.CurrentHealth)
	HealthLabelUpdate(MaxHealthLabel, get_parent().Player.MaxHealth)
	
	AmmoLabelUpdate(get_parent().Player.find_child("WeaponManager"),CurrentAmmoLabel,MaxAmmoLabel)
	
func HealthLabelUpdate(LabelToUpdate: Label, PlayerHealth : float):
	var temp : String = str(PlayerHealth)
	LabelToUpdate.text = temp.get_slice(".",0)

func AmmoLabelUpdate(WManager : WeaponManager, CAmmo : Label, MAmmo : Label):
	WManager.CurrentWeapon.AmmoType
	
	CAmmo.text = str(WManager.HeldAmmo[str(WManager.CurrentWeapon.AmmoType)+"-CurrentAmmo"])
	MAmmo.text = str(WManager.HeldAmmo[str(WManager.CurrentWeapon.AmmoType)+"-MaxAmmo"])
	


func _FaceLocation():
	var temp = get_parent().Player.CurrentHealth/ get_parent().Player.MaxHealth
	if str(temp).length() >= 4:
		temp = float(str(temp).substr(0,-1))
	temp = temp *10
	FaceCoords.y = (temp)
	FaceSprite.frame_coords = FaceCoords
	
func _FaceXCoordChange() -> void:
	FaceTimer.wait_time = randf_range(0.5,1)
	
	if  get_parent().Player.IsAttacking == true:
		FaceCoords.x =AngryFace.pick_random()
	if  get_parent().Player.IsAttacking == false:
		FaceCoords.x =IdleFace.pick_random()
	FaceTimer.start()
	
