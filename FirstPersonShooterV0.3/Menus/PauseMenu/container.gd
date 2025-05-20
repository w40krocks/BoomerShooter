extends Container

@onready var PauseMenu = $".."
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PauseMenu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		Pause_Cycle()

func _Resume() -> void:
	Pause_Cycle()

func _Quit() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Menus/MainMenu/MainMenu.tscn")

func Pause_Cycle():
	if paused == true:
		PauseMenu.hide()
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		PauseMenu.show()
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	paused = !paused
