extends RayWeapon
class_name  Pistol



func _ready() -> void:
	Enter()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	AttackCheck("Attack")
