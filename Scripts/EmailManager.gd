class_name EmailManager extends Node

signal email_picked_up(email: EmailResource)
signal new_email(email: EmailResource)

# emitted whenever an email is submitted, and gives the id of that email
signal email_submitted(email_id: StringName)

@export var email_order: Array[EmailResource]

var is_carrying_email: bool = false
var _index: int = 0

var current_email: EmailResource :
	get():
		if _index < email_order.size():
			return email_order[_index]
		return null

func pickup_email():
	email_picked_up.emit(current_email)

	is_carrying_email = true

func submit_email():
	email_submitted.emit(current_email.id)
	new_email.emit(current_email)
	
	_index += 1
	is_carrying_email = false
	
	Wwise.post_event("PLAY_SFX_EmailWhoosh", self)
