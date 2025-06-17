extends Node3D

@onready var sSystem := SaveSystem.new()

func _ready() -> void:
	Engine.time_scale = 1
	if Global.loadingSave:
		sSystem.LoadSaveFile(self)
		Global.loadingSave = false
