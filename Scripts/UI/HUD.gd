class_name HUD extends Control

@onready var dboxContainer := $DialogueBox/NinePatchRect/MarginContainer/VBoxContainer

func display_email(email: EmailResource):
	dboxContainer.get_node("From").text = email.fromAddress
	dboxContainer.get_node("To").text = email.toAddress
	dboxContainer.get_node("Subject").text = email.subject
	dboxContainer.get_node("Contents").text = email.contents
	$AnimationPlayer.play("DisplayDialog")

func close_email():
	$AnimationPlayer.play("CloseDialog")
	
func _process(_delta):
	mouse_filter = Control.MOUSE_FILTER_STOP if visible else Control.MOUSE_FILTER_IGNORE 
