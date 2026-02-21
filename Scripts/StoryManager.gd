extends Node

@onready var parkourContainer := $"../ParkourSegments"
var parkourSegments : Array[Node3D] = []

var currentActiveIdx := 0

func _ready():
	GlobalEmailManager.connect("email_submitted", on_email_submitted)
	
	for segment in parkourContainer.get_children():
		parkourSegments.append(segment)
		parkourContainer.remove_child(segment)
		segment.visible = false
	
	# maybe we start off with no parkour
	#parkourContainer.add_child(parkourSegments[0])
	#parkourSegments[0].visible = true

func enable_parkour(idx: int):
	if idx < 0 or idx >= parkourSegments.size():
		print("PARKOUR SEGMENT " + str(idx) + " IS NOT PRESENT")
		return
	
	parkourContainer.remove_child(parkourSegments[currentActiveIdx])
	parkourSegments[currentActiveIdx].visible = false
	
	currentActiveIdx = idx
	
	parkourContainer.add_child(parkourSegments[currentActiveIdx])
	parkourSegments[currentActiveIdx].visible = true

# Maybe we can switch on the index of an email and hard-code the paths to scenes that contain what we want to swap out
func on_email_submitted(email_id: StringName):
	match email_id:
		"email_01":
			enable_parkour(0)
		"email_02":
			enable_parkour(1)
		"email_03":
			enable_parkour(2)
		"email_04":
			enable_parkour(3)
		"email_05":
			enable_parkour(4)
		"email_06":
			enable_parkour(5)
		"email_07":
			enable_parkour(6)
		"email_08":
			enable_parkour(7)
		"email_09":
			enable_parkour(1)
		"email_10":
			enable_parkour(2)
		"email_11":
			enable_parkour(3)
		"email_12":
			enable_parkour(4)
		"email_13":
			enable_parkour(5)
		"email_14":
			enable_parkour(6)
		"email_15":
			enable_parkour(7)
		"email_16":
			# we have 8 regular parkour segments, and then i suppose a final 9th special one will appear on the last part
			enable_parkour(8)
