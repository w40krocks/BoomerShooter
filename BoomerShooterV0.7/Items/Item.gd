extends Area3D
class_name BaseItem


var ItemVisuals : Node3D = find_child("Item Visual")
@onready var ItemAnimation : AnimationPlayer = find_child("Item Animator")
@export var ItemAmount : int
func Pickup(Enteredbody : Node3D):
	pass

func CanBodyPickup(Enteredbody : Node3D):
	if Enteredbody is Player:
		return true
	else:
		return false

func Delete():
	queue_free()

func PlayAnimation(AnimationName : String):
	ItemAnimation.play(AnimationName)
