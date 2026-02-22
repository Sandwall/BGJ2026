class_name HUD extends CanvasLayer

@export var vbox_container : VBoxContainer
@export var animation_player : AnimationPlayer

const CLOSE_DELAY := 2.0

var open := false
var timer := 0.0

func display_email(email: EmailResource):
	vbox_container.get_node("From").text = "From: " + email.fromAddress
	vbox_container.get_node("To").text = "To: " + email.toAddress
	vbox_container.get_node("Subject").text = "Subject: " + email.subject
	vbox_container.get_node("Contents").text = email.contents
	animation_player.play("DisplayDialog")
	
	open = true
	Wwise.post_event("PLAY_DX", self)


func display_test_email():
	var testEmail := EmailResource.new()
	display_email(testEmail)

func close_email():
	animation_player.play("CloseDialog")
	
func _process(delta):
	if open:
		timer += delta
		if timer >= CLOSE_DELAY and Input.is_action_just_pressed("plr_interact"):
			open = false
			animation_player.play("CloseDialog")
			timer = 0.0

func _ready() -> void:
	pass
	#display_test_email()
