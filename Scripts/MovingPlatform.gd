extends PathFollow3D

@export var timeLength := 5.0
@export var doPingpong := true
@export var sitLength := 0.0

var forward := true
var sitTimer := 0.0

func _physics_process(delta: float):
	var moveAmount := delta / timeLength
	
	#  basically the platform sits at each edge for a little bit
	#  to let the player hop on instead of instantly leaving
	if sitTimer >= 0.0:
		sitTimer -= delta
	else:
		if doPingpong:
			loop = false
			if forward:
				progress_ratio += moveAmount
				if progress_ratio >= 1.0:
					sitTimer = sitLength
					progress_ratio = 1.0 - moveAmount
					forward = false
			else:
				progress_ratio -= moveAmount
				if progress_ratio <= 0.0:
					sitTimer = sitLength
					progress_ratio = moveAmount
					forward = true
		else:
			loop = true
			progress_ratio += moveAmount
		
