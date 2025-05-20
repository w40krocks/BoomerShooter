extends Area3D

@onready var test = get_tree().current_scene.find_child("CharacterBody3D")

func _on_body_entered(test: CharacterBody3D) -> void:
	test.ShotgunUnlocked = true
	test._GunChoice(3)
	self.queue_free()
