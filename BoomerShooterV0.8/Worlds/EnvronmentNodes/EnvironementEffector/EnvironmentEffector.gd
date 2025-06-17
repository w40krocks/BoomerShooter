extends Node
class_name EnvironmentEffector

@export var Effectees : Array ##determines what is effected when this node is triggered, only store Effectees in here

signal Triggered ## Format for emitting (Triggered(self))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in Effectees.size():
		Effectees[i] as Effectee
		Triggered.connect(Effectees[i].Triggered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
