extends Node3D


@onready var playerRef := Main.inst.plr

func _process(delta):
	if playerRef == null: return
	
	# basically says that if my forward vector is misaligned with the player's forward vector,
	# then just do a 180 degree rotation to turn around
	if global_basis.z.dot(playerRef.global_basis.z) < 0.0:
		rotation.y += PI
