extends "res://Weapons/weapon.gd"

@onready var ProjectileSpawnLocation = $ProjectileSpawnLocation

var WeaponProjectileScene : String
var TargetPosition : Vector3
var SpawnPosition : Vector3
var ProjectileSprite : String
var ProjectileHframes : int
var ProjectileRange : float
var ProjectileSpeed : float

func Attack():
	if Engine.time_scale == 1:
		CurrentAmmo -= 1
		WeaponAnimation()
		var temp = load(WeaponProjectileScene).instantiate()
		temp.name = (WeaponName)
		temp.position = ProjectileSpawnLocation.global_position
		temp.StartPosition = global_position
		temp.ProjectileSpeed = ProjectileSpeed
		temp.Damage = Damage
		temp.ProjectileRange = ProjectileRange
		temp.Sprite = ProjectileSprite
		temp.SpriteHframe = ProjectileHframes
		temp.Direction = global_position.direction_to(ProjectileSpawnLocation.global_position)
		get_parent().get_parent().get_parent().get_parent().add_child(temp)
