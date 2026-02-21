extends PathFollow3D

@export var timeLength := 5.0
@export var doPingpong := true

var forward := true


func _physics_process(delta: float):
	var moveAmount := delta / timeLength
	
	if doPingpong:
		loop = false
		if forward:
			progress_ratio += moveAmount
			if progress_ratio >= 1.0:
				progress_ratio = 1.0 - moveAmount
				forward = false
		else:
			progress_ratio -= moveAmount
			if progress_ratio <= 0.0:
				progress_ratio = moveAmount
				forward = true
	else:
		loop = true
		progress_ratio += moveAmount
		
