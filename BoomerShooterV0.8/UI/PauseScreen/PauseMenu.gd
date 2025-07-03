extends Control

@export var MainPauseOptions : BoxContainer
@export var OptionsMenu : BoxContainer

@export var CamSenseSlider : HSlider
@export var FOVSlider : HSlider

@export var FOVLabel : Label
@export var CamSenseLabel : Label

@onready var BaseCamSense : float= find_parent("Player").find_child("PlayerCam").CamSense
@onready var BaseFOV = find_parent("Player").find_child("PlayerCam").fov

func _ready() -> void:
	FOVLabel.text = str(BaseFOV).get_slice(".",0)
	CamSenseLabel.text = str(BaseCamSense * 1000).get_slice(".",0)

func PauseSwitch():
	if Engine.time_scale == 1:
		MainPauseOptions.show()
		OptionsMenu.hide()
		self.hide()
	else:
		MainPauseOptions.show()
		OptionsMenu.hide()
		self.show()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		if get_parent().CharacterStat.CurrentHealth > 0:
			PauseSwitch()

func Button_ResumePressed():
	Engine.time_scale = 1
	PauseSwitch()

func Button_OptionsPressed():
	MainPauseOptions.hide()
	OptionsMenu.show()

func Button_ExitPressed():
	var sSystem = SaveSystem.new()
	sSystem.CreateSaveFile(get_tree().current_scene)
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")

func Button_RestartPressed():
	get_tree().reload_current_scene()
	Engine.time_scale = 1

func Button_BackPressed():
	MainPauseOptions.show()
	OptionsMenu.hide()

func Button_ResetPressed():
	find_parent("Player").find_child("PlayerCam").CamSense = BaseCamSense
	find_parent("Player").find_child("PlayerCam").fov = BaseFOV
	CamSenseSlider.value = BaseCamSense
	FOVSlider.value = BaseFOV

func Button_UserFeedback():
	OS.shell_open("https://docs.google.com/forms/d/e/1FAIpQLScQgdKE5u6ukxPNBnBz9UXjCK0UODuC2sbhxhhMt5S8YNeG1A/viewform?usp=header")

func SensitivitySliderAltered(NewValue : float):
	find_parent("Player").find_child("PlayerCam").CamSense = NewValue
	CamSenseLabel.text = str(NewValue * 1000).get_slice(".",0)

func FOVSliderAltered(NewValue : float):
	find_parent("Player").find_child("PlayerCam").fov = NewValue
	FOVLabel.text = str(NewValue).get_slice(".",0)

func Button_CheckpointRestart():
	var sSaveSystem = SaveSystem.new()
	sSaveSystem.LoadSaveFile(get_tree().current_scene)
