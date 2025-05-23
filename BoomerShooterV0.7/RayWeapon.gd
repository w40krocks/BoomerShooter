extends BaseWeapon
class_name RayWeapon


@onready var WeaponRay : RayCast3D = find_child("Ray")
@onready var EndOfBarrel : Node3D = find_child("EndOfBarrel")
@export var WeaponSplinter : int

func RandomiseRay():
	WeaponRay.rotation_degrees.x = randf_range(-ShotAngleRandomRange.x,ShotAngleRandomRange.x)
	WeaponRay.rotation_degrees.y = randf_range(-ShotAngleRandomRange.y,ShotAngleRandomRange.y)
	WeaponRay.force_raycast_update()

func ResetRay():
	WeaponRay.rotation = Vector3(0,0,0)

func AttackCheck(AttackName : String):
	if CanShoot(AttackName):
		match IsAttacking(AttackName):
			
			#Single Fire
			0:
				for i in WeaponSplinter:
					if WeaponSplinter != i +1:
						RandomiseRay()
					else:
						ResetRay()
					Attack()
				TakeAmmo()
				WeaponAni.play(AttackName)
				return true
			#Refiring
			1:
				for i in WeaponSplinter:
					RandomiseRay()
					Attack()
				TakeAmmo()
				WeaponAni.play(AttackName)
				return true
			#Not Firing
			2:
				return false

func _process(delta: float) -> void:
	AttackCheck("Attack")
	AttackCheck("Alt Attack")

func Attack():
	if WeaponRay.is_colliding():
	
		var GunSmoke = load("res://Weapons/gun_impact.tscn").instantiate()
		GunSmoke.position = WeaponRay.get_collision_point()
		CreateBulletTrail()
		get_tree().current_scene.add_child(GunSmoke)

		if WeaponRay.get_collider() is BaseEnemy:
			WeaponRay.get_collider().HealthChange(-Damage)

func CreateBulletTrail():
	var temp = load("res://Weapons/RayWeapons/Gun Trail.tscn").instantiate()
	temp.emission_box_extents = Vector3(0.1,0.1,EndOfBarrel.global_position.distance_to(WeaponRay.get_collision_point())*0.5)
	temp.amount = temp.emission_box_extents.z * 5
	temp.look_at_from_position((EndOfBarrel.global_position + WeaponRay.get_collision_point())/2,WeaponRay.get_collision_point())
	get_tree().current_scene.add_child(temp)
