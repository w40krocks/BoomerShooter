extends BaseCharacter
class_name PlayerCharacter

@onready var IsOnGround : bool = false

@onready var IsAttacking : bool = false

@onready var Animator : AnimationPlayer = $AnimationPlayer

@onready var GroundSlamming : bool = false

@export var DeathScreen : Sprite2D

@export_category("AudioPlayers")
@export var FootStepPlayer : AudioStreamPlayer3D
@export var HealthChangePlayer : AudioStreamPlayer3D
@export var ThudPlayer : AudioStreamPlayer3D

var Momentum : Vector3


@export_category("Audio Files")
@export var Footsteps : AudioStreamWAV
@export var Jump : AudioStreamWAV
@export var Slam : AudioStreamWAV
@export var Thud : AudioStreamWAV
@export var Hurt : AudioStreamRandomizer
@export var Heal : AudioStreamRandomizer
@export var DeathScream : AudioStreamWAV


func _ready():
	SetStatsInstance()
	CharacterStat.CharacterName = self.name

func _process(delta: float) -> void:
	if !CharacterStat.IsAlive:
		DeathScreen.scale = DisplayServer.window_get_size() * 4
		DeathScreen.show()
	else:
		DeathScreen.hide()
	FootstepTuning()
	
	
	if Input.is_action_just_pressed("Pause"):
		if CharacterStat.IsAlive == true:
			PauseSwitch()
	
	if Input.is_action_just_pressed("Debug Button"):
		Reposition()
		load("res://TestingStuff/testResource.tres").Num += 1
		print(load("res://TestingStuff/testResource.tres").Num)

func _physics_process(delta: float) -> void:
	if GroundSlamming:
			if is_on_floor():
				Animator.play("GroundSlam")
				ThudPlayer.stream = Slam
				ThudPlayer.playing = true
				GroundSlamming = false
				IsOnGround = true
				
	elif !IsOnGround and is_on_floor():
		IsOnGround = true
		ThudPlayer.stream = Thud
		ThudPlayer.playing = true

	if not is_on_floor():
		IsOnGround = false
		velocity += get_gravity() * delta
	# Handle jump.
	
	
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = CharacterStat.JumpSpeed 
		ThudPlayer.stream = Jump
		ThudPlayer.playing = true
		
	if Engine.time_scale == 1:
		Movement()
	
	if Input.is_action_just_pressed("Down"):
		if not is_on_floor():
			GroundSlam()
	move_and_slide()

func HealthChange(HealthChange : float):
	CharacterStat.CurrentHealth += HealthChange
	if CharacterStat.CurrentHealth <= 0:
		HealthChangePlayer.stream = DeathScream
		HealthChangePlayer.playing = true
		Death()
		
	elif HealthChange < 0:
		HealthChangePlayer.stream = Hurt
		HealthChangePlayer.playing = true
	else:
		HealthChangePlayer.stream = Heal
		HealthChangePlayer.playing = true
	
	if CharacterStat.CurrentHealth >= CharacterStat.MaxHealth:
		CharacterStat.CurrentHealth = CharacterStat.MaxHealth
		

func Death(): 
	CharacterStat.IsAlive = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	find_child("Resume").hide()
	Engine.time_scale = 0
	find_child("Control").show()

func PauseSwitch(): ## sets timescale to 0 if unpaused, sets timescale to 1 if paused
	if Engine.time_scale == 1:
		Engine.time_scale = 0
	else:
		Engine.time_scale = 1

func Movement(): ##handles the acceleration, deceleration and limiting character speed based on whether the player is in the air or not
	
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if is_on_floor():
			velocity.x += direction.x * CharacterStat.MoveSpeed 
			velocity.z += direction.z * CharacterStat.MoveSpeed 
			velocity = velocity.limit_length(CharacterStat.MaxGroundSpeed)
		else:
			velocity.x += direction.x * (CharacterStat.MoveSpeed*0.1)
			velocity.z += direction.z * (CharacterStat.MoveSpeed*0.1)
			velocity = velocity.limit_length(CharacterStat.MaxAirSpeed)
		Momentum = velocity
	else:
		if Momentum.z != 0:
			#applies friction to decelerate the player
			if is_on_floor():
				Momentum.z *= 0.85
			else:
				Momentum.z *= 0.97
		if Momentum.x != 0:
			#applies friction to decelerate the player
			if is_on_floor():
				Momentum.x *= 0.85
			else:
				Momentum.x *= 0.97
			
		if abs(Momentum.x) < 0.01:
			Momentum.x = 0
		if abs(Momentum.z) < 0.01:
			Momentum.z = 0
		
		velocity.x = move_toward(velocity.x, Momentum.x, CharacterStat.MoveSpeed * 2)
		velocity.z = move_toward(velocity.z, Momentum.z, CharacterStat.MoveSpeed* 2)

func GroundSlam(): ## multiplies gravity applied to the player and resets the players momentum, and sets the GroundSlamming variable to true
	GroundSlamming = true
	velocity = Vector3(0,get_gravity().y * 2,0)
	Momentum = Vector3(0,0,0)

func Reposition(): ## resets player momentum and repositions player to the relocate position of the last visited level area
	Momentum = Vector3(0,0,0)
	if CharacterStat.LastVisitedArea:
		if CharacterStat.LastVisitedArea.RelocateNode:
			position = CharacterStat.LastVisitedArea.RelocateNode.global_position

func FootstepTuning():
	#if paused, not moving horizontally or not on the ground
	if velocity.x == 0 and velocity.y == 0 or !is_on_floor() or Engine.time_scale == 0:
		FootStepPlayer.playing = false
	#if moving, unpaused and on the ground
	else:
		if FootStepPlayer.playing == false:
			FootStepPlayer.playing = true
		if FootStepPlayer.stream != Footsteps:
			FootStepPlayer.stream = Footsteps
		
		FootStepPlayer.pitch_scale = (abs(velocity.x) + abs(velocity.z))/15 
		
