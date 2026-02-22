class_name MailSendBox
extends MeshInstance3D

signal not_carrying_mail
signal wrong_host
signal sent_mail

@export var host_email: String
@export var email_pickup: EmailPickup

func interact():
	if not GlobalEmailManager.is_carrying_email:
		print("CANT SEND IF NOT CARRYING EMAIL")
		Wwise.post_event("PLAY_SFX_Error", self)
		not_carrying_mail.emit()
		return

	if GlobalEmailManager.current_email.toAddress != host_email:
		print("MAIL DOES NOT BELONG TO THIS HOST")
		Wwise.post_event("PLAY_SFX_Error", self)
		wrong_host.emit()
		return

	GlobalEmailManager.submit_email()

	print("SENT EMAIL")
	sent_mail.emit()

	if email_pickup:
		email_pickup.set_available(true)
