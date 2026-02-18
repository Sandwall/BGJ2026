class_name HUD extends Control

@onready var dboxContainer := $DialogueBox/NinePatchRect/MarginContainer/VBoxContainer

func display_email(email: EmailResource):
	dboxContainer.get_node("From").text = "From: " + email.fromAddress
	dboxContainer.get_node("To").text = "To: " + email.toAddress
	dboxContainer.get_node("Subject").text = "Subject: " + email.subject
	dboxContainer.get_node("Contents").text = email.contents
	$AnimationPlayer.play("DisplayDialog")

func display_test_email():
	var testEmail := EmailResource.new()
	display_email(testEmail)

func close_email():
	$AnimationPlayer.play("CloseDialog")
	
func _process(_delta):
	pass
	# mouse_filter = Control.MOUSE_FILTER_STOP if visible else Control.MOUSE_FILTER_IGNORE
