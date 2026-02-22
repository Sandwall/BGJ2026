class_name EmailPickup
extends MeshInstance3D

signal error_pickup
signal picked_up
signal available_changed(value: bool)

@export var start_available: bool = false

var _start_position: Vector3

func _ready() -> void:
	_start_position = global_position

	set_available(start_available)

func set_available(value: bool):
	if value:
		global_position = _start_position
	else:
		global_position = _start_position
		global_position.y -= 2
	
	available_changed.emit(value)

func display_email():
	GlobalEmailManager.pickup_email()
	Main.inst.hud.display_email(GlobalEmailManager.current_email)

func interact():
	if GlobalEmailManager.is_carrying_email:
		print("CANT PICKUP IF CARRYING EMAIL")
		error_pickup.emit()
		return

	picked_up.emit()

	print("PICKED UP EMAIL")
