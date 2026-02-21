class_name EmailManager extends Node

signal email_picked_up(email: EmailResource)
signal new_email(email: EmailResource)

# gives the 
signal email_submitted(idx: int)

@export var email_order: Array[EmailResource]

var current_email: EmailResource :
	get():
		if _index < email_order.size():
			return email_order[_index]
		return null

var is_carrying_email: bool = false

var _index: int = 0

func pickup_email():
	email_picked_up.emit(current_email)

	is_carrying_email = true

func submit_email():
	email_submitted.emit(_index)
	new_email.emit(current_email)
	
	_index += 1
	is_carrying_email = false
