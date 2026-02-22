class_name Main extends Node

static var inst: Main = null

@onready var hud: HUD = $HUD
@onready var plr: Player = null

@onready var worldRef : Node3D = $SubViewportContainer/SubViewport/World
@onready var pauseScreen := $Pause

func _init():
	inst = self
	
	# DELETE THIS I'M JUST KEEPING IT HERE FOR TESTING
	Wwise.shutdown()

func _process(delta):
	if Input.is_action_just_pressed("plr_pause"):
		get_tree().paused = !get_tree().paused
		pauseScreen.visible = get_tree().paused
