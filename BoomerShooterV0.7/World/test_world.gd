extends Node3D

@onready var timer := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += 1
	if timer == 100:
		SetSpecialEnemy.new().SetSpecialEnemy(find_child("Zombie0"),Color(1.0,1.0,0.0))
		SetSpecialEnemy.new().SetSpecialEnemy(find_child("Zombie1"),Color(0.0,1.0,1.0))
		SetSpecialEnemy.new().SetSpecialEnemy(find_child("Zombie2"),Color(0.0,0.0,1.0))
		SetSpecialEnemy.new().SetSpecialEnemy(find_child("Zombie3"),Color(0.5,0.5,0.5))
		SetSpecialEnemy.new().SetSpecialEnemy(find_child("Zombie4"),Color(0.5,1.0,0.5))
