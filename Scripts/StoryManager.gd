extends Node

@onready var parkourContainer := $"../ParkourSegments"
var parkourSegments: Array[Node3D] = []

@onready var duckyContainer := $"../DuckieStage"
@onready var duckySegments : Array[Node3D] = [$"../DuckieStage/DuckieStageOffice", $"../DuckieStage/DuckieStageSpaceAge", $"../DuckieStage/DuckieStageSurreal"]

@onready var victoriaContainer := $"../VictoriaStage"
var victoriaSegmentPaths: Array[String] = [
	"res://Scenes/Stage/VictoriaStage01.tscn",
	"res://Scenes/Stage/VictoriaStage02.tscn",
	"res://Scenes/Stage/VictoriaStage03.tscn",
	"res://Scenes/Stage/VictoriaStage04.tscn",
	"res://Scenes/Stage/VictoriaStage05.tscn",
	"res://Scenes/Stage/VictoriaStage06.tscn",
	"res://Scenes/Stage/VictoriaStage07.tscn",
	"res://Scenes/Stage/VictoriaStage08.tscn"
]
var victoriaSegments : Array[Node3D] = []

var parkourIdx := 0
var duckyIdx := 0
var victoriaIdx := 0

func _ready():
	GlobalEmailManager.email_picked_up.connect(on_email_obtained)
	GlobalEmailManager.new_email.connect(on_email_delivered)
	
	# cache parkour segments
	for segment in parkourContainer.get_children():
		parkourSegments.append(segment)
		parkourContainer.remove_child(segment)
		segment.visible = false
	
	# cache ducky segments
	for segment in duckySegments:
		duckyContainer.remove_child(segment)
	
	duckyContainer.add_child(duckySegments[0])
	
	# load and cache victoria segments
	# some of the victoria scenes are large, so we'll load them from here
	for segmentPath in victoriaSegmentPaths:
		var segment = load(segmentPath).instantiate()
		victoriaSegments.append(segment)
	
	enable_parkour(0)
	swap_victoria(0)

func enable_parkour(idx: int):
	if idx < 0 or idx >= parkourSegments.size():
		print("PARKOUR SEGMENT " + str(idx) + " IS NOT PRESENT")
		return
	
	if parkourContainer.get_children().size() > 0:
		parkourContainer.remove_child(parkourSegments[parkourIdx])
		parkourSegments[parkourIdx].visible = false
	
	parkourIdx = idx
	
	parkourContainer.add_child(parkourSegments[parkourIdx])
	parkourSegments[parkourIdx].visible = true

func swap_ducky(idx: int):
	if idx < 0 or idx >= duckySegments.size():
		print("DUCKY SEGMENT " + str(idx) + " IS NOT PRESENT")
		return
		
	if duckyContainer.get_children().size() > 0:
		duckyContainer.remove_child(duckySegments[duckyIdx])
		duckySegments[duckyIdx].visible = false
	
	duckyIdx = idx
	
	duckyContainer.add_child(duckySegments[duckyIdx])
	duckySegments[duckyIdx].visible = true

func swap_victoria(idx: int):
	if idx < 0 or idx >= victoriaSegments.size():
		print("VICKY SEGMENT " + str(idx) + " IS NOT PRESENT")
		return
		
	if victoriaContainer.get_children().size() > 0:
		victoriaContainer.remove_child(victoriaSegments[victoriaIdx])
		victoriaSegments[victoriaIdx].visible = false
	
	victoriaIdx = idx
	
	victoriaContainer.add_child(victoriaSegments[victoriaIdx])
	victoriaSegments[victoriaIdx].visible = true

func on_email_delivered(email: EmailResource):
	match email.id:
		"email_01":
			pass
		"email_02":
			swap_victoria(1)
		"email_03":
			pass
		"email_04":
			swap_victoria(2)
		"email_05":
			swap_ducky(1)
		"email_06":
			swap_victoria(3)
		"email_07":
			pass
		"email_08":
			swap_victoria(4)
		"email_09":
			pass
		"email_10":
			swap_victoria(5)
		"email_11":
			swap_ducky(2)
		"email_12":
			swap_victoria(6)
		"email_13":
			pass
		"email_14":
			swap_victoria(7)
		"email_15":
			pass
		"email_16":
			await get_tree().create_timer(2.0).timeout
			Transition.latest.change("res://Scenes/TitleMenu.tscn")

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
