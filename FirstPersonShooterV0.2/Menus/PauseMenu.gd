extends Container

@onready var Pause_Menu =$".."
var paused = false
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	Pause_Menu.hide()

func _ResumePressed() -> void:
	Pause_Cycle()

func _QuitPressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")

func Pause_Cycle():
	if paused == true:
		Pause_Menu.hide()
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Pause_Menu.show()
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	paused = !paused
