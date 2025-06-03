extends BaseWeapon
class_name RayWeapon
@export_category("RayWeaponStats")
@export var WeaponSplinter : int ## the amount of rays the weapon shoots in a single attack
@export var RayRandomRange : Vector2 ##the bounds in which the rotation of the ray can be randomisied 
@export var WeaponRay : RayCast3D ##the raycast the Weapon uses to shoot

@export_category("RayWeaponSceneInfo")
@export var HitMarker : PackedScene ##the particle emitted when the gun shoots something
@export var BulletTrail : PackedScene ##a particle trail that goes from the end of the guns barrel to the point the ray has collided with
@export var EndOfBarrel : Node3D ##a node used to get the position at the end of the weapons barrel

func RayReset(): ##resets the rotation of the raycast to 0
	WeaponRay.rotation = Vector3(0,0,0)
	WeaponRay.force_raycast_update()

func WeaponRayRandomiser(): ##randomises the rotation of the raycast based around
	WeaponRay.rotation_degrees.x = randf_range(-RayRandomRange.x,RayRandomRange.x)
	WeaponRay.rotation_degrees.y = randf_range(-RayRandomRange.y,RayRandomRange.y)
	WeaponRay.force_raycast_update()

func AttackCheck(AnimationName : String):
	if CanAttack(AnimationName):
		if HasAmmoToFire():
			match IsAttacking():
				0:
					WeaponAnimator.play(AnimationName)
					for i in WeaponSplinter:
						if i == WeaponSplinter:
							RayReset()
						else:
							WeaponRayRandomiser()
						Attack()
				1:
					WeaponAnimator.play(AnimationName)
					for i in WeaponSplinter:
						WeaponRayRandomiser()
						Attack()
				2:
					#isnt firing
					pass

func Attack():
	if WeaponRay.is_colliding():
		CreateBulletTrail(WeaponRay.get_collision_point())
		if WeaponRay.get_collider() is BaseCharacter:
			var temp = WeaponRay.get_collider().DamageParticle.instaniate()
			temp.global_position = WeaponRay.get_collision_point()
			get_tree().current_scene.add_child(temp)

			WeaponRay.get_collider().HealthChange(randf_range(MinDamage,MaxDamage))
		else:
			var temp = HitMarker.instantiate()
			temp.global_position = WeaponRay.get_collision_point()
			get_tree().current_scene.add_child(temp)
	else:
		#get gun smoke trail and its length to the z target
		pass

func CreateBulletTrail(EndPoint : Vector3):
	var temp = BulletTrail.instantiate()
	temp.emission_box_extents = Vector3(0.1,0.1,EndOfBarrel.global_position.distance_to(EndPoint)*0.5)
	temp.amount = temp.emission_box_extents.z * 5
	temp.look_at_from_position((EndOfBarrel.global_position + EndPoint)*0.5,WeaponRay.get_collision_point())
	get_tree().current_scene.add_child(temp)
