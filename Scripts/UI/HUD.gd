class_name HUD extends CanvasLayer

@export var vbox_container : VBoxContainer
@export var animation_player : AnimationPlayer

func display_email(email: EmailResource):
	vbox_container.get_node("From").text = "From: " + email.fromAddress
	vbox_container.get_node("To").text = "To: " + email.toAddress
	vbox_container.get_node("Subject").text = "Subject: " + email.subject
	vbox_container.get_node("Contents").text = email.contents
	animation_player.play("DisplayDialog")
	
	#await get_tree().create_timer(0.5).timeout
	
	Wwise.post_event("PLAY_DX", self)

	await get_tree().create_timer(5.0).timeout

	animation_player.play("CloseDialog")

func display_test_email():
	var testEmail := EmailResource.new()
	display_email(testEmail)

func close_email():
	animation_player.play("CloseDialog")
	
func _process(_delta):
	pass

func _ready() -> void:
	display_test_email()
