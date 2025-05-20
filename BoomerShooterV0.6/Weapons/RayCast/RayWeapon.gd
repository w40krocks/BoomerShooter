extends "res://Weapons/weapon.gd"

@onready var RayCast = $RayCast

@onready var GunSmoke = "res://Weapons/RayCast/GunSmoke.tscn"

#---RayInfo
var Xscale : float
var Yscale : float
var Ztarget : float
#---RayInfo
	
func SetRays():
	RayCast.scale.x = Xscale
	RayCast.scale.y = Yscale
	RayCast.target_position.z = -Ztarget


func Attack():
	if Engine.time_scale ==1:
		WeaponAnimation()
		CurrentAmmo -= 1
		if RayCast.is_colliding():
			if RayCast.get_collider().name.substr(0,5) == "Enemy":
				RayCast.get_collider()._HealthChange(-Damage)
			SpawnGunSmoke(RayCast.get_collision_point(),global_rotation.y)

func SpawnGunSmoke(SmokePos : Vector3, SmokeRotate):
	var temp = load(GunSmoke).instantiate()
	temp.position = SmokePos + ((global_position - SmokePos).normalized())/50
	temp.rotation.y += SmokeRotate
	temp.scale.x = 5
	temp.scale.y = 5
	find_parent("Player").get_parent().add_child(temp)
