extends Area3D
@onready var test = get_tree().current_scene.find_child("CharacterBody3D")

func _on_body_entered(body: Node3D) -> void:
	test.PistolAmmo = test.PistolAmmo + 10
	self.queue_free()
