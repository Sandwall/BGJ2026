class_name MailSendBox
extends MeshInstance3D

@export var host_email: String
@export var email_pickup: EmailPickup

func interact():
	if not GlobalEmailManager.is_carrying_email:
		print("CANT SEND IF NOT CARRYING EMAIL")
		return

	if GlobalEmailManager.current_email.toAddress != host_email:
		print("MAIL DOES NOT BELONG TO THIS HOST")
		return

	GlobalEmailManager.submit_email()

	print("SENT EMAIL")

	if email_pickup:
		email_pickup.set_available(true)