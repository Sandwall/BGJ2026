class_name EmailPickup
extends MeshInstance3D

func interact():
	if GlobalEmailManager.is_carrying_email:
		print("CANT PICKUP IF CARRYING EMAIL")
		return

	GlobalEmailManager.pickup_email()

	Main.inst.hud.display_email(GlobalEmailManager.current_email)

	print("PICKED UP EMAIL")