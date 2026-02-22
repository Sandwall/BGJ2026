class_name DuckieAnimator
extends Node

@export var send_box: MailSendBox
@export var animated_sprite_3d: AnimatedSprite3D

@export var idle_name: String
@export var talk_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	send_box.not_carrying_mail.connect(_on_not_carrying_mail)
	send_box.wrong_host.connect(_on_wrong_host)

	play_idle()

func _on_not_carrying_mail():
	play_talk()
	await get_tree().create_timer(1.5).timeout;
	play_idle()

func _on_wrong_host():
	play_talk()
	await get_tree().create_timer(1.5).timeout;
	play_idle()

func _on_sent_mail():
	play_talk()
	await get_tree().create_timer(5.0).timeout;
	play_idle()

func play_idle():
	animated_sprite_3d.play(idle_name)

func play_talk():
	animated_sprite_3d.play(talk_name)