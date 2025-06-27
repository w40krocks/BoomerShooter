extends BaseEnemy
class_name GrassRaptor

@export var AttackArea : Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetStatsInstance()
	CharacterStat.CharacterName = self.name
	CharacterStat.SpawnPos = global_position
	CharacterStat.SpawnRotation = global_rotation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label3D.text = str(CharacterStat.CurrentHealth).substr(0,5)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta *0.75
	
	velocity.x = move_toward(velocity.x, velocity.x *0.95, CharacterStat.MoveSpeed)
	velocity.z = move_toward(velocity.z, velocity.z *0.95, CharacterStat.MoveSpeed)
	move_and_slide()

func Death():
	if CharacterStat.IsAlive:
		find_child("StateMachine")._StateTransition(find_child("StateMachine").CurrentState,"EnemyDeath")

func Attack(body : Node3D):
	if body is BaseCharacter:
		if body == self:
			pass
		else:
			body.HealthChange(-CharacterStat.MeleeDamage)
			find_child("StateMachine")._StateTransition(find_child("StateMachine").CurrentState,"GrassRaptorRetreat")
