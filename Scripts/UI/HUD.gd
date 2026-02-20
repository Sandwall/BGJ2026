class_name HUD extends CanvasLayer

@export var vbox_container : VBoxContainer

func display_email(email: EmailResource):
	vbox_container.get_node("From").text = "From: " + email.fromAddress
	vbox_container.get_node("To").text = "To: " + email.toAddress
	vbox_container.get_node("Subject").text = "Subject: " + email.subject
	vbox_container.get_node("Contents").text = email.contents
	$AnimationPlayer.play("DisplayDialog")

func display_test_email():
	var testEmail := EmailResource.new()
	display_email(testEmail)

func close_email():
	$AnimationPlayer.play("CloseDialog")
	
func _process(_delta):
	pass
	# mouse_filter = Control.MOUSE_FILTER_STOP if visible else Control.MOUSE_FILTER_IGNORE
