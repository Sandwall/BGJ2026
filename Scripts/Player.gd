extends CharacterBody3D

@onready var cameraRef := $Camera3D

@export_group("Physics Constants")
@export var GROUND_SPEED := 4.5
@export var AIR_SPEED := 3.0
@export var JUMP_VELOCITY := 4.5

@export_group("Camera Constants")
@export var cameraSens := Vector2(0.5, 0.5)

#
# INPUT VALUES
#
var moveInput := Vector2.ZERO
var lookInput := Vector2.ZERO

#
# PHYSICS STATE VARIABLES
#

# these two are in "view-space"
var lateralVelocity := Vector2.ZERO
var verticalVelocity := 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		var mouseEvent = event as InputEventMouseMotion
		lookInput += mouseEvent.relative

func _physics_process(delta):
	# gather relevant inputs
	moveInput = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	lookInput *= cameraSens # mouse input is done in the _input function...
	
	# mutate camera orientation
	cameraRef.rotation.x -= lookInput.y * delta
	cameraRef.rotation.x = clampf(cameraRef.rotation.x, -PI / 2.0, PI / 2.0)
	rotation.y = wrapf(rotation.y - (lookInput.x * delta), 0, 2.0 * PI)
	
	# apply gravity
	if not is_on_floor():
		verticalVelocity -= get_gravity().length() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		verticalVelocity = JUMP_VELOCITY

	if moveInput:
		lateralVelocity = moveInput * GROUND_SPEED
	else:
		lateralVelocity.x = move_toward(lateralVelocity.x, 0, GROUND_SPEED)
		lateralVelocity.y = move_toward(lateralVelocity.y, 0, GROUND_SPEED)

	velocity = combine_velocity(lateralVelocity, verticalVelocity)
	move_and_slide()
	
	# after-update updates
	lookInput = Vector2.ZERO

func combine_velocity(lateral: Vector2, vertical: float) -> Vector3:
	return (transform.basis * Vector3(lateral.x, 0, lateral.y)) + (vertical * transform.basis.y)
