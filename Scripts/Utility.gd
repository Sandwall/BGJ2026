class_name Utility

static func filerp(current, target, decay: float, delta: float):
	return target + (current - target) * exp(-decay * delta)

# current and target must be radians
# works for an angle in the range [-PI, PI]
# this is probably a really bad way to do this, go look at how lerp_angle does it
static func filerp_angle(current, target, decay, delta):
	var adiff = abs(target - current)
	var aresid = TAU - adiff
	
	if adiff > PI:
		if target > 0:
			current = target + aresid
		else:
			current = target - aresid
	
	return filerp(current, target, decay, delta)

# now i want frame independent slerping
static func fislerp(current, target, decay: float, delta: float):
	return current.slerp(target, 1 - exp(-decay * delta))
