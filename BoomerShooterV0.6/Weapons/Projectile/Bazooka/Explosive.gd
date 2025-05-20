extends "res://Weapons/Projectile/Projectile.gd"

@onready var Explosion = "res://Weapons/Projectile/Bazooka/explosion.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ReachedEndDistance = false
	SetProjectileInfo()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ReachedEndDistance != true:
		ProjectileSpeed += 15 * delta
		ProjectileMovement(delta)
	else:
		_CollideWithSurface(null)

func _CollideWithSurface(_body: Node3D) -> void:
	var temp = load(Explosion).instantiate()
	temp.Damage = 20
	temp.position = global_position
	get_parent().add_child(temp)
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.name.substr(area.name.length()-9,area.name.length()) == "Explosion":
		var temp = load(Explosion).instantiate()
		temp.Damage = 20
		temp.global_position = global_position
		get_parent().add_child(temp)
		queue_free()
