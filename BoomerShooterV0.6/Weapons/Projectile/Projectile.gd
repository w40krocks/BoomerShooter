extends Area3D

@onready var AnimationTimer = $AnimationTimer
@onready var ProjectileLight = $ProjectileLight
@onready var ProjectileSprite = $ProjectileSprite

var Damage : float
var Direction
var Distance : float
var ProjectileSpeed : float

var Sprite : String
var SpriteHframe : int
var SpawnLocation : Vector3
var StartPosition : Vector3

var CurrentAnimation : int
var ReachedEndDistance : bool
var ProjectileRange : float


func SetProjectileInfo():
	SpawnLocation = position
	ProjectileSprite.texture = load(Sprite)
	ProjectileSprite.hframes = SpriteHframe
	
	ReachedEndDistance = false
	ProjectileSprite.frame_coords = Vector2(0,0)

func ProjectileMovement(delta):
	Distance = position.distance_to(SpawnLocation)
	position += Direction * ProjectileSpeed * delta
	if Distance > ProjectileRange:
		ReachedEndDistance = true

func ProjectileAnimation():
	CurrentAnimation += 1
	if CurrentAnimation != SpriteHframe:
		ProjectileSprite.frame_coords.x = CurrentAnimation
		AnimationTimer.start()
	else:
		CurrentAnimation = 0
		ProjectileSprite.frame_coords.x = CurrentAnimation
