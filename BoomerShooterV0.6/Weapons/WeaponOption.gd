extends PanelContainer

func _setOptionInfo(Name : String ,Ammo : int, Sprite : String, SpriteScale : float):
	$WeaponName.text = Name
	$WeaponAmmo.text = str(Ammo)
	$SpriteLocalSet/WeaponDisplay.texture = load(Sprite)
	$SpriteLocalSet/WeaponDisplay.scale = Vector2(SpriteScale,SpriteScale)
