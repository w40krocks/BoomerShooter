extends Area3D

@onready var character= $"../../CharacterBody3D"

#when the area is entered deal 20 damage to player
func _on_area_3d_area_entered(area: Area3D) -> void:
	character._HealthChange(-20)
