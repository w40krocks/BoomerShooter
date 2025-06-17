extends CharacterStats
class_name EnemyStats

@export_category("Enemy Stats")
@export var AwarenessZone : float ##the distance around the enemy, where the player will be spotted immediately
@export var SearchDistance : float ##the distance from the enemy where the player can be spotted
@export var ConeOfVision : float ##the rotational distance from the front enemy, determines how wide or narrow the enemies distance
