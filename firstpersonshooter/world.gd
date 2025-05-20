extends Node3D

#this is a script I created to relocate the UI elements based on the current resolutiom of the screen
#it is stupid and unneeded due to the UI nodes i later learned to use

@onready var pause_menu = $PauseMenu

@onready var HealthContainer = $HealthContainer
@onready var Health = $HealthContainer2
@onready var Gun = $CharacterBody3D/Head/Camera3D/Gun
@onready var Face = $CharacterBody3D/Head/Camera3D/Label
@onready var Crosshair = $Crosshair

var Gun_xPos
var Gun_yPos
var Health_xPos
var Health_yPos
var Face_xPos
var Face_yPos
var Pause_xPos
var Pause_yPos
var Crosshair_xPos
var Crosshair_yPos

var paused = false

func _ready():
	_RepositionWeapon()
	_RepositionHealth()
	_RepositionFace()

func _process(_float):
	#checks if UI Positions match their Intended position based off of the screen resolution
	if Gun_xPos != DisplayServer.window_get_size().x /2 or Gun_yPos != DisplayServer.window_get_size().y -50:
		_RepositionWeapon()
	
	if Health_xPos != DisplayServer.window_get_size().x -100 or Health_yPos != DisplayServer.window_get_size().y * 0.2:
		_RepositionHealth()
	
	if Face_xPos != DisplayServer.window_get_size().x * 0.03 or Face_yPos != DisplayServer.window_get_size().y -200:
		_RepositionFace()
		
	if Pause_xPos != DisplayServer.window_get_size().x /2 or Pause_yPos != DisplayServer.window_get_size().y /2:
		_RepositionPauseMenu()
		
	if Crosshair_xPos != DisplayServer.window_get_size().x /2 or Crosshair_yPos != DisplayServer.window_get_size().y /2:
		_RepositionCrosshair()
	
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()

#runs where the player presses the pause key
func pauseMenu():
	#if paused then unpause
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#if unpaused then pause
	else:
		pause_menu.show()
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	paused = !paused

#puts the gun in the middle horozontially and bottom vertically
func _RepositionWeapon():
	Gun_xPos = DisplayServer.window_get_size().x /2
	Gun_yPos = DisplayServer.window_get_size().y -100
	Gun.position.x = Gun_xPos
	Gun.position.y = Gun_yPos

func _RepositionHealth():
	Health_xPos = DisplayServer.window_get_size().x -100
	Health_yPos = DisplayServer.window_get_size().y * 0.2 
	HealthContainer.position.x = Health_xPos
	HealthContainer.position.y = Health_yPos
	Health.position.x = Health_xPos
	Health.position.y = Health_yPos
	
func _RepositionFace():
	Face_xPos = DisplayServer.window_get_size().x * 0.03
	Face_yPos = DisplayServer.window_get_size().y -200
	Face.position.x = Face_xPos
	Face.position.y = Face_yPos

func _RepositionPauseMenu():
	Pause_xPos = DisplayServer.window_get_size().x * 0.1
	Pause_yPos = DisplayServer.window_get_size().y * 0.1
	pause_menu.position.x = Pause_xPos
	pause_menu.position.y = Pause_yPos
	
func _RepositionCrosshair():
	Crosshair_xPos = DisplayServer.window_get_size().x /2
	Crosshair_yPos = DisplayServer.window_get_size().y /2
	Crosshair.position.x = Crosshair_xPos
	Crosshair.position.y = Crosshair_yPos
