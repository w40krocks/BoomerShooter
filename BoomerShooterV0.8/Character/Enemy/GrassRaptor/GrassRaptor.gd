extends BaseEnemy
class_name GrassRaptor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var temp : Vector3
	temp.x = Target.position.x
	temp.y = self.position.y
	temp.z = Target.position.z
	if Input.is_action_just_pressed("Attack") and CurrentHealth > 0:
		look_at(temp)
		find_child("AnimationPlayer").play("Walk")
	$Label3D.text = str(CurrentHealth).substr(0,5)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta *0.75
	
	velocity.x = move_toward(velocity.x, 0, MoveSpeed)
	velocity.z = move_toward(velocity.z, 0, MoveSpeed)
	move_and_slide()

func Death():
	#if
	rotation_degrees.z = 90
