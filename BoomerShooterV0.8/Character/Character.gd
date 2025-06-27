extends CharacterBody3D
class_name BaseCharacter

@export var CharacterStat : CharacterStats

func HealthChange(HealthChange : float): ##ran anytime a characters health is to change ALWAYS USE THIS, do not directly change the characters health (if this is being used to deal damage, make sure the variable is negative)
	CharacterStat.CurrentHealth += HealthChange
	
	if CharacterStat.CurrentHealth >= CharacterStat.MaxHealth:
		CharacterStat.CurrentHealth = CharacterStat.MaxHealth
	if CharacterStat.CurrentHealth <= 0:
		Death()

func Death(): ##ran when the character reaches the death state
	pass

func SetStatsInstance():
	CharacterStat = CharacterStat.duplicate()
