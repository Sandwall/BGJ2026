extends Node3D

@onready var prevAllow = GlobalEmailManager.is_carrying_email

func _process(delta):
	var allow := !GlobalEmailManager.is_carrying_email
	visible = allow
	$StaticBody3D/CollisionShape3D.disabled = !allow

	if allow != prevAllow:
		if visible:
			Wwise.post_event("PLAY_SFX_Firewall", $FireWall)
		else:
			Wwise.post_event("STOP_SFX_Firewall", $FireWall)

	prevAllow = allow
