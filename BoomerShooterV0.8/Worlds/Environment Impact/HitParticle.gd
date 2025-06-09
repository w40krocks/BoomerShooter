extends CPUParticles3D
class_name HitParticle

func _ready() -> void:
	emitting = true
	finished.connect(Finished)

func Finished():
	queue_free()
