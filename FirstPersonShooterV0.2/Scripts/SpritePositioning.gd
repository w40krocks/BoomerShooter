extends Node2D

#Current Coordinates on the screen
var Pistol_xPos
var Pistol_yPos 
#Desired position on the screen
@export var Pistol_Set_xPos = 0.075
@export var Pistol_Set_yPos = 0.2

var Shotgun_xPos
var Shotgun_yPos 
@export var Shotgun_Set_xPos = 0.075
@export var Shotgun_Set_yPos = 0.2

var Unarmed_xPos
var Unarmed_yPos 
@export var Unarmed_Set_xPos = 0.075
@export var Unarmed_Set_yPos = 0.2

var Face_xPos
var Face_yPos
@export var Face_Set_xPos = 0.5
@export var Face_Set_yPos = 0.1

var HealthC_xPos
var HealthC_yPos

var Health_xPos
var Health_yPos
@export var Health_Set_xPos = 0.925
@export var Health_Set_yPos = 0.15

var Crosshair_xPos
var Crosshair_yPos
@export var Crosshair_Set_xPos = 0.5
@export var Crosshair_Set_yPos = 0.5

#calls all sprites that will be repositioned
@onready var Unarmed = $Weapons/Unarmed
@onready var Pistol = $Weapons/Pistol
@onready var Shotgun = $Weapons/Shotgun

@onready var Face = $Face
@onready var HealthContainer = $HealthContainer
@onready var Health = $Health
@onready var Crosshair = $Crosshair

#runs first frame the thing its attached to is loaded
func _ready() -> void:
	_RepositionSprite(Unarmed_xPos, Unarmed_yPos, Unarmed_Set_xPos, Unarmed_Set_yPos, Unarmed)
	_RepositionSprite(Pistol_xPos, Pistol_yPos, Pistol_Set_xPos, Pistol_Set_yPos, Pistol)
	_RepositionSprite(Shotgun_xPos, Shotgun_yPos, Shotgun_Set_xPos, Shotgun_Set_yPos, Shotgun)
	_RepositionSprite(Face_xPos, Face_yPos, Face_Set_xPos, Face_Set_yPos, Face)
	_RepositionSprite(Health_xPos, Health_yPos, Health_Set_xPos, Health_Set_yPos, Health)
	_RepositionSprite(HealthC_xPos, HealthC_yPos, Health_Set_xPos, Health_Set_yPos, HealthContainer)
	_RepositionSprite(Crosshair_xPos, Crosshair_yPos, Crosshair_Set_xPos, Crosshair_Set_yPos, Crosshair)
func _process(delta: float) -> void:
	#sets window boundaries as smaller variables for easier readability
	var X = DisplayServer.window_get_size().x
	var Y = DisplayServer.window_get_size().y
	
	#checks if sprites are in the correct position
	if Unarmed_xPos != X * Unarmed_Set_xPos or Unarmed_yPos != Y * Unarmed_Set_yPos:
		_RepositionSprite(Unarmed_xPos, Unarmed_yPos, Unarmed_Set_xPos, Unarmed_Set_yPos, Unarmed)
		
	if Pistol_xPos != X * Pistol_Set_xPos or Pistol_yPos != Y * Pistol_Set_yPos:
		_RepositionSprite(Pistol_xPos, Pistol_yPos, Pistol_Set_xPos, Pistol_Set_yPos, Pistol)
		
	if Shotgun_xPos != X * Shotgun_Set_xPos or Shotgun_yPos != Y * Shotgun_Set_yPos:
		_RepositionSprite(Shotgun_xPos, Shotgun_yPos, Shotgun_Set_xPos, Shotgun_Set_yPos, Shotgun)
		
	if Face_xPos != X * Face_Set_xPos or Face_yPos != Y * Face_Set_yPos:
		_RepositionSprite(Face_xPos, Face_yPos, Face_Set_xPos, Face_Set_yPos, Face)
		
	if Health_xPos != X *Health_Set_xPos or Health_yPos != Y * Health_Set_yPos:
		_RepositionSprite(Health_xPos, Health_yPos, Health_Set_xPos, Health_Set_yPos, Health)
		
	if HealthC_xPos != X *Health_Set_xPos or HealthC_yPos != Y * Health_Set_yPos:
		_RepositionSprite(HealthC_xPos, HealthC_yPos, Health_Set_xPos, Health_Set_yPos, HealthContainer)
		
	if Crosshair_xPos != X * Crosshair_Set_xPos or Crosshair_yPos != Y * Crosshair_Set_yPos:
		_RepositionSprite(Crosshair_xPos, Crosshair_yPos, Crosshair_Set_xPos, Crosshair_Set_yPos, Crosshair)
#repositions the gun sprite

func _RepositionSprite(Sprite_xPos, Sprite_yPos, Sprite_Set_xPos, Sprite_Set_yPos, Sprite):
	Sprite_xPos = DisplayServer.window_get_size().x * Sprite_Set_xPos
	Sprite_yPos = DisplayServer.window_get_size().y * Sprite_Set_yPos
	Sprite.position.x = Sprite_xPos
	Sprite.position.y = Sprite_yPos
