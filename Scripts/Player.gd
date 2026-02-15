extends CharacterBody3D

@onready var cameraRef := $Camera3D

@export_group("Physics Constants")

# self explanatory
@export var GROUND_ACCEL_TIME := 0.05
@export var GROUND_DECEL_TIME := 0.2
@export var GROUND_SPEED := 4.5

@export var AIR_ACCEL_DECEL_TIME := 0.25
@export var AIR_SPEED := 3.0

@export var JUMP_VELOCITY := 4.5

@export_group("Camera Constants")
@export var cameraSens := Vector2(0.3, 0.3)

#
# INPUT VALUES
#
var moveInput := Vector2.ZERO
var prevMoveInput := Vector2.ZERO
var lookInput := Vector2.ZERO
var jumpClicked := false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		lookInput += (event as InputEventMouseMotion).relative

func _physics_process(delta):
	# gather relevant inputs
	moveInput = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").limit_length(1.0)
	lookInput *= cameraSens * delta # mouse input is done in the _input function...
	jumpClicked = Input.is_action_just_pressed("ui_accept")

	# pre-update updates
	update_camera()
	
	# main movement code
	var wantLateralVelocity := transform.basis * Vector3(moveInput.x, 0.0, moveInput.y)

	if is_on_floor():
		if moveInput.length_squared() > 0.0005:
			velocity.x += wantLateralVelocity.x * GROUND_SPEED * delta / GROUND_ACCEL_TIME
			velocity.z += wantLateralVelocity.z * GROUND_SPEED * delta / GROUND_ACCEL_TIME
		else:
			velocity.x = move_toward(velocity.x, 0.0, GROUND_SPEED * delta / GROUND_DECEL_TIME)
			velocity.z = move_toward(velocity.z, 0.0, GROUND_SPEED * delta / GROUND_DECEL_TIME)

		velocity.x = clampf(velocity.x, -GROUND_SPEED, GROUND_SPEED)
		velocity.z = clampf(velocity.z, -GROUND_SPEED, GROUND_SPEED)

		if jumpClicked:
			velocity.y = JUMP_VELOCITY
	else:
		velocity.y += get_gravity().y * delta

		# player should be able to move as fast as they can on the air (albeit with some drag when turning)
		# as they can in the air as long as they keep up some input
		if moveInput.length_squared() > 0.0005:
			velocity.x += wantLateralVelocity.x * AIR_SPEED * delta / AIR_ACCEL_DECEL_TIME
			velocity.z += wantLateralVelocity.z * AIR_SPEED * delta / AIR_ACCEL_DECEL_TIME
			velocity.x = clampf(velocity.x, -GROUND_SPEED, GROUND_SPEED)
			velocity.z = clampf(velocity.z, -GROUND_SPEED, GROUND_SPEED)
		else:
			var wantClamped := Vector2(clampf(velocity.x, -AIR_SPEED, AIR_SPEED), clampf(velocity.z, -AIR_SPEED, AIR_SPEED))
			velocity.x = move_toward(velocity.x, wantClamped.x, GROUND_SPEED * delta / AIR_ACCEL_DECEL_TIME)
			velocity.z = move_toward(velocity.z, wantClamped.y, GROUND_SPEED * delta / AIR_ACCEL_DECEL_TIME)

	move_and_slide()
	
	# after-update updates
	lookInput = Vector2.ZERO
	prevMoveInput = moveInput

func update_camera() -> void:
	cameraRef.rotation.x -= lookInput.y
	cameraRef.rotation.x = clampf(cameraRef.rotation.x, -PI / 2.0, PI / 2.0)
	rotation.y = wrapf(rotation.y - (lookInput.x), 0, 2.0 * PI)
