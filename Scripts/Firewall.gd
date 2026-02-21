extends Node3D

func _process(delta):
	var allow := !GlobalEmailManager.is_carrying_email
	visible = allow
	$StaticBody3D/CollisionShape3D.disabled = !allow
