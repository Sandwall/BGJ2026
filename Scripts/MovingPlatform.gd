extends PathFollow3D

@export var timeLength := 5.0

func _physics_process(delta):
	progress += delta / timeLength
