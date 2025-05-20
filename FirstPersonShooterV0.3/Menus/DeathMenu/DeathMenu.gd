extends Container

@onready var DeathMenu = $""
@onready var Player = $"."

#NOTE need to change this to the current loaded world scene
func _Restart() -> void:
	get_tree().change_scene_to_file("res://Worlds/TestWorld/TestWorld.tscn")

func _Quit() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Menus/MainMenu/MainMenu.tscn")
