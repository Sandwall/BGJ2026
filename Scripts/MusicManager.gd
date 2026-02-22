extends Node

func _on_victoria_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		Wwise.post_event("STATE_MX_Professional", self)
		Wwise.post_event("STATE_SFX_Carpet", self)

func _on_victoria_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		Wwise.post_event("STATE_MX_Exploration", self)
		Wwise.post_event("STATE_SFX_Stone", self)

func _on_ducky_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		Wwise.post_event("STATE_MX_Quirky", self)
		Wwise.post_event("STATE_SFX_Squelch", self)

func _on_ducky_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		Wwise.post_event("STATE_MX_Exploration", self)
		Wwise.post_event("STATE_SFX_Stone", self)
