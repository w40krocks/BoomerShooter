extends CharacterStats
class_name PlayerStats

var LastVisitedArea : LevelArea ##stores the last level area entered, this is used for the relocation function
@export var JumpSpeed := 5
@export var MaxAirSpeed := 30 ##defines the maximum speed a player can reach midair
@export var MaxGroundSpeed := 16 ##defines the maximum speed a player can reach on the ground
