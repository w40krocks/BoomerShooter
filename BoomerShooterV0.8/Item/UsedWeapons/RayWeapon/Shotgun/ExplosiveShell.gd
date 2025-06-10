extends RigidBody3D

@export var Explosion : PackedScene


func Collided(body: Node) -> void:
	if body.is_in_group("ExplosionTrigger"):
		Explode()


func Explode():
	var temp = Explosion.instantiate()
	temp.position = global_position
	get_tree().current_scene.add_child(temp)
	self.queue_free()
