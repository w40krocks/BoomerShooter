extends AnimatedSprite2D

var xPos = DisplayServer.window_get_size().x /2
var yPos = DisplayServer.window_get_size().y -100

# Called when the node enters the scene tree for the first time.
func _Reposition():
	xPos = DisplayServer.window_get_size().x /2
	yPos = DisplayServer.window_get_size().y -100
	print(xPos)
	print(yPos)
	position.x = xPos
	position.y = yPos

func _ready() -> void:
	_Reposition()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if xPos != DisplayServer.window_get_size().x /2 or yPos != DisplayServer.window_get_size().y -50:
		_Reposition()
	pass
