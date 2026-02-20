class_name MailPickup
extends MeshInstance3D

func interact():
	if not GlobalEmailManager.is_carrying_email:
		print("CANT SEND IF NOT CARRYING EMAIL")
		return

	GlobalEmailManager.submit_email()

	print("SENT EMAIL")