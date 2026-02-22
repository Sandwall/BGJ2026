class_name Main extends Node

static var inst: Main = null

@onready var hud: HUD = $HUD
@onready var plr: Player = null

@onready var worldRef : Node3D = $SubViewportContainer/SubViewport/World
@onready var pauseScreen := $Pause

func _init():
	inst = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	if Input.is_action_just_pressed("plr_pause"):
		get_tree().paused = !get_tree().paused
		pauseScreen.visible = get_tree().paused
		if get_tree().paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			Wwise.post_event("PLAY_SFX_UISelect", self)
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			Wwise.post_event("PLAY_SFX_UIBack", self)
