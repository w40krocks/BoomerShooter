extends CharacterBody3D
class_name BaseCharacter



@export_category("Movement")
@export var MoveSpeed : float ##Player uses this as acceleration stat
@export var JumpSpeed : float

@export_category("Health Info")
@export var CurrentHealth : float ##The health that the character is currently on
@export var MaxHealth : float ##the maximum amount of health a character can have, the HealthChange function should check if the Characters new health exceeds the max, if so set current health as max health
@export var MaxOverHealth : float ##not sure if i will make use of this

@export_category("Damage Particle")
@export var DamageParticle : PackedScene

func HealthChange(HealthChange : float): ##ran anytime a characters health is to change ALWAYS USE THIS, do not directly change the characters health (if this is being used to deal damage, make sure the variable is negative)
	CurrentHealth += HealthChange
	
	if CurrentHealth >= MaxHealth:
		CurrentHealth = MaxHealth
	if CurrentHealth <= 0:
		Death()

func Death(): ##ran when the character reaches the death state
	pass
