extends Node

@onready var parkourContainer := $"../ParkourSegments"
var parkourSegments: Array[Node3D] = []

var currentActiveIdx := 0

func _ready():
	GlobalEmailManager.email_picked_up.connect(on_email_obtained)
	
	for segment in parkourContainer.get_children():
		parkourSegments.append(segment)
		parkourContainer.remove_child(segment)
		segment.visible = false
	
	enable_parkour(0)

func enable_parkour(idx: int):
	if idx < 0 or idx >= parkourSegments.size():
		print("PARKOUR SEGMENT " + str(idx) + " IS NOT PRESENT")
		return
	
	if parkourContainer.get_children().size() > 0:
		parkourContainer.remove_child(parkourSegments[currentActiveIdx])
		parkourSegments[currentActiveIdx].visible = false
	
	currentActiveIdx = idx
	
	parkourContainer.add_child(parkourSegments[currentActiveIdx])
	parkourSegments[currentActiveIdx].visible = true

# Maybe we can switch on the index of an email and hard-code the paths to scenes that contain what we want to swap out
func on_email_obtained(email: EmailResource):
	match email.id:
		"email_01":
			enable_parkour(0)
		"email_02":
			pass
		"email_03":
			enable_parkour(1)
		"email_04":
			pass
		"email_05":
			enable_parkour(2)
		"email_06":
			pass
		"email_07":
			enable_parkour(3)
		"email_08":
			Wwise.post_event("RTPC_MX_Layering", self)
		"email_09":
			enable_parkour(4)
		"email_10":
			pass
		"email_11":
			enable_parkour(5)
		"email_12":
			pass
		"email_13":
			enable_parkour(6)
		"email_14":
			pass
		"email_15":
			enable_parkour(7)
		"email_16":
			pass
