extends Node

func _ready():
	GlobalEmailManager.connect("email_submitted", on_email_submitted)

# Maybe we can switch on the index of an email and hard-code the paths to scenes that contain what we want to swap out
func on_email_submitted(idx: int):
	pass
