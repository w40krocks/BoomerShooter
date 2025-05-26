extends Area3D




func BodyEntered(body: Node3D) -> void:
	if body.is_in_group("Launchable"):
		if body is BaseCharacter:
			body.velocity.y += 10
		elif body is RigidBody3D:
			body.apply_force(Vector3(0,500,0))
