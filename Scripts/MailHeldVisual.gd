extends Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	GlobalEmailManager.email_picked_up.connect(_on_email_picked_up)
	GlobalEmailManager.new_email.connect(_on_new_email)

func _on_new_email(_email: EmailResource):
	visible = false

func _on_email_picked_up(_email: EmailResource):
	visible = true
