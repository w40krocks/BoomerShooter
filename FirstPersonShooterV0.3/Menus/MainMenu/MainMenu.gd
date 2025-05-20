extends Container

func _StartButtonPressed() -> void:
	get_tree().change_scene_to_file("res://Worlds/TestWorld/TestWorld.tscn")
	print("test")

func _Quit() -> void:
	get_tree().quit()
