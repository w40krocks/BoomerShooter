extends Resource
class_name CharacterStats

@export var MoveSpeed : float

@export var CurrentHealth : float
@export var MaxHealth : float
@export var DamageParticle : PackedScene


#("Save Info")
@export var SpawnPos : Vector3 ##saves the position the character will be spawned into when the level is reloaded
@export var SpawnRotation : Vector3
@export var IsAlive : bool
@export var CharacterName : String


func test():
	push_error(ResourceSaver.save(self, "user://Character/Player/StartingPlayerStats.tres"))
