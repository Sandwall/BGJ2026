class_name EmailPickup
extends MeshInstance3D

signal error_pickup
signal picked_up
signal available_changed(value: bool)

@export var start_available: bool = false

@onready var collisionRef := $StaticBody3D/CollisionShape3D

func _ready() -> void:
	set_available(start_available)

func set_available(value: bool):
	if value:
		visible = true
		collisionRef.disabled = false
	else:
		visible = false
		collisionRef.disabled = true

	available_changed.emit(value)

func display_email():
	GlobalEmailManager.pickup_email()
	Main.inst.hud.display_email(GlobalEmailManager.current_email)

func interact():
	if GlobalEmailManager.is_carrying_email:
		print("CANT PICKUP IF CARRYING EMAIL")
		Wwise.post_event("PLAY_SFX_Error", self)
		error_pickup.emit()
		return

	picked_up.emit()

	print("PICKED UP EMAIL")
