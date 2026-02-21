class_name EmailPickup
extends MeshInstance3D

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
		global_position.y -= 50

func interact():
	if GlobalEmailManager.is_carrying_email:
		print("CANT PICKUP IF CARRYING EMAIL")
		return

	GlobalEmailManager.pickup_email()

	set_available(false)

	Main.inst.hud.display_email(GlobalEmailManager.current_email)

	print("PICKED UP EMAIL")
