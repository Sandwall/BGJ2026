extends Node

@onready var parkourContainer := $"../InterconnectStage"
var parkourSegments : Array[Node3D] = []

var currentActiveIdx := 0

func _ready():
	GlobalEmailManager.connect("email_submitted", on_email_submitted)
	
	for segment in parkourContainer.get_children():
		parkourSegments.append(segment)
		parkourContainer.remove_child(segment)
		segment.visible = false
		
	parkourContainer.add_child(parkourSegments[0])
	parkourSegments[0].visible = true

func enable_parkour(idx: int):
	parkourContainer.remove_child(parkourSegments[currentActiveIdx])
	parkourSegments[currentActiveIdx].visible = false
	
	currentActiveIdx = idx
	
	parkourContainer.add_child(parkourSegments[currentActiveIdx])
	parkourSegments[currentActiveIdx].visible = true

# Maybe we can switch on the index of an email and hard-code the paths to scenes that contain what we want to swap out
func on_email_submitted(idx: int):
	enable_parkour(idx)
