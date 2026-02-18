class_name Main extends Node

static var inst: Main = null

@onready var hud: HUD = $HUD
@onready var plr: Player = null

func _ready():
	inst = self


func _process(delta):
	pass
