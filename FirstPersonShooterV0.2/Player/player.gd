extends CharacterBody3D
class_name Player

var SENSITIVITY = 0.01
var Health = 100.0
var ShootCooldownState: bool= false
var CurrentWeapon


@onready var Head = $PlayerShape/Head
@onready var Camera = $PlayerShape/Head/PlayerCam
@onready var Face = $PlayerShape/Head/PlayerCam/Sprites/Face
@onready var Pause = $"PauseMenu/Container"

var test = 1
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready():
	Face.play("Idle")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	#checks if pause button is pressed
	if Input.is_action_just_pressed("Pause"):
		Pause.Pause_Cycle()

#allows for camera movement with the mouse
func _unhandled_input(event):
	#checks if game is paused, if not allows camera movement
	if Engine.time_scale == 1:
		if event is InputEventMouseMotion:
			Head.rotate_y(-event.relative.x * SENSITIVITY)
			Camera.rotate_x(-event.relative.y * SENSITIVITY)
			Camera.rotation.x = clamp(Camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
	else:
		pass
#controls movement
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = (Head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
func _getPlayerCamPos():
	Camera = get_node(".")
	print()
	var Result : Vector2
	Result.x = Player.global_position.x
	Result.y = global_position.z
	return Result
