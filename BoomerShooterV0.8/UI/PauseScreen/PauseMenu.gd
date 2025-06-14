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
	CamSenseLabel.text = str(BaseCamSense * 10000).get_slice(".",0)
	
	
	pass

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
		PauseSwitch()

func Button_ResumePressed():
	Engine.time_scale = 1
	PauseSwitch()

func Button_OptionsPressed():
	MainPauseOptions.hide()
	OptionsMenu.show()

func Button_ExitPressed():
	pass

func Button_RestartPressed():
	pass

func Button_BackPressed():
	MainPauseOptions.show()
	OptionsMenu.hide()


func Button_ResetPressed():
	find_parent("Player").find_child("PlayerCam").CamSense = BaseCamSense
	find_parent("Player").find_child("PlayerCam").fov = BaseFOV
	
	
	CamSenseSlider.value = BaseCamSense
	FOVSlider.value = BaseFOV

func SensitivitySliderAltered(NewValue : float):
	find_parent("Player").find_child("PlayerCam").CamSense = NewValue
	CamSenseLabel.text = str(NewValue * 10000).get_slice(".",0)

func FOVSliderAltered(NewValue : float):
	find_parent("Player").find_child("PlayerCam").fov = NewValue
	FOVLabel.text = str(NewValue).get_slice(".",0)
