extends EnvironmentEffector

@onready var Pressed := false

func AreaEntered(Area : Area3D):
	if !Pressed:
		if Area.name == "GroundSlam":
			$AnimationPlayer.play("Pressed")
			Triggered.emit(self)
			Pressed = true
