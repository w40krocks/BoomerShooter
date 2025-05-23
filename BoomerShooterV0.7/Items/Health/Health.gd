extends BaseItem
class_name HealthItem

func _ready() -> void:
	PlayAnimation("Default")

func Pickup(Enteredbody : Node3D):
	print("entered")
	if CanBodyPickup(Enteredbody):
		if Enteredbody.Health != Enteredbody.MaxHealth:
			Enteredbody.HealthChange(ItemAmount)
			Delete()
