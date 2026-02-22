class_name MailAnimator
extends Node

@export var email_pickup: EmailPickup
@export var animated_sprite_3d: AnimatedSprite3D

func _ready() -> void:
	email_pickup.picked_up.connect(_on_picked_up)
	email_pickup.available_changed.connect(_on_available_changed)

func _on_picked_up():
	animated_sprite_3d.play("pickup")
	
	await animated_sprite_3d.animation_finished
	
	email_pickup.set_available(false)
	email_pickup.display_email()

func _on_available_changed(value: bool):
	if value:
		animated_sprite_3d.play("idle")
