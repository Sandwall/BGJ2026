class_name VictoriaAnimator
extends Node

@export var send_box: MailSendBox
@export var animation_tree: AnimationTree

var tree_root: AnimationNodeStateMachinePlayback

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tree_root = animation_tree["parameters/playback"]
	
	send_box.not_carrying_mail.connect(play_confused)
	send_box.wrong_host.connect(play_confused)
	send_box.sent_mail.connect(play_receive)

func play_receive():
	tree_root.travel("VictoriaReceive")

func play_confused():
	tree_root.travel("VictoriaInquisitive")
