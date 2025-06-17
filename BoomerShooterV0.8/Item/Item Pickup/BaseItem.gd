extends Area3D
class_name BaseItem

@export_category("In Scene stuff")
@export var ItemModel : Node3D
@export var ItemModelAnimator : AnimationPlayer

@export_category("ItemStats")
@export var ConsumableAmount : float

func PlayIdleAnimation():
	ItemModelAnimator.play("Idle")

func ConnectSignal():
	body_entered.connect(ItemEntered)

func AttemptPickUp(body : PlayerCharacter):
	pass

func ItemEntered(body : Node3D):
	if body is PlayerCharacter:
		if AttemptPickUp(body):
			self.queue_free()
