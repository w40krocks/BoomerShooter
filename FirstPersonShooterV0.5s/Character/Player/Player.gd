extends "res://Character/Character.gd"

@onready var Camera = $Head/Camera

var Front : int

const TurnValue : Vector3 = Vector3(0,90,0)

const JUMP_VELOCITY = 4.5
func _ready():
	Health = 100
	MoveSpeed = 5

func _process(delta: float) -> void:
	TileMovement()
	CameraMovement()
	DetermineDirection()

func TileMovement():
	if Input.is_action_just_pressed("Forward"):
		match Front:
			0:
				self.position.z -= 5
			90:
				self.position.x -= 5
			180:
				self.position.z += 5
			270:
				self.position.x += 5
	elif Input.is_action_just_pressed("Right"):
		match Front:
			0:
				self.position.x += 5
			90:
				self.position.z -= 5
			180:
				self.position.x -= 5
			270:
				self.position.z += 5
	elif Input.is_action_just_pressed("Left"):
		match Front:
			0:
				self.position.x -= 5
			90:
				self.position.z += 5
			180:
				self.position.x += 5
			270:
				self.position.z -= 5
	elif Input.is_action_just_pressed("Backward"):
		match Front:
			0:
				self.position.z += 5
			90:
				self.position.x += 5
			180:
				self.position.z -= 5
			270:
				self.position.x -= 5


func CameraMovement():
	if Input.is_action_just_pressed("Turn Right"):
		self.rotation_degrees.y -= 90
	if Input.is_action_just_pressed("Turn Left"):
		self.rotation_degrees.y += 90
	
func DetermineDirection():
	var temp : int = self.rotation_degrees.y
	while temp >= 360:
		temp -=360
	while temp < 0:
		temp +=360
	Front = temp
