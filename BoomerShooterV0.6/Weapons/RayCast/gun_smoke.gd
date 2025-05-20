extends Sprite3D

var Hframes

func _ready() -> void:
	Hframes = 0
	
func _on_timer_timeout() -> void:
	Hframes +=1
	if Hframes == 2:
		queue_free()
	else:
		frame_coords.x = Hframes
