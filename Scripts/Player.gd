class_name Player extends CharacterBody3D

# node references
@onready var cameraRef := $Camera3D
@onready var viewCast := $Camera3D/InteractCast
@onready var targetOutline: MeshInstance3D = $TargetOutline

@export_group("Physics Constants")

@export var GROUND_ACCEL_TIME := 0.1
@export var GROUND_DECEL_TIME := 0.3
@export var GROUND_SPEED := 4.0
@export var AIR_ACCEL_DECEL_TIME := 0.25
@export var AIR_SPEED := 3.0
@export var JUMP_VELOCITY := 4.5

@export_group("Camera Constants")
@export var cameraSens := Vector2(0.3, 0.3)
@export var cameraSensController := Vector2(2.0, 2.0)
@export var RESPAWN_HEIGHT := 150.0
@export var FOOTSTEP_TIME := 0.6;

var footstepTimer := 3.0;
#
# INPUT VALUES
#
var moveInput := Vector2.ZERO
var prevMoveInput := Vector2.ZERO
var lookInput := Vector2.ZERO
var jumpClicked := false
var interactClicked := false

#
# STATE VALUES
#

# player's inputs don't go through when respawning...
@export var lastRespawnPoint : Checkpoint = null
var respawning := false
var prevOnGround := true

func _ready():
	Main.inst.plr = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		lookInput += (event as InputEventMouseMotion).relative

func _process(_delta):
	targetOutline.mesh = null
	targetOutline.visible = false

	var target = viewCast.get_collider() as Node3D
	if target is CollisionObject3D:
		if target.get_collision_layer_value(2): # interaction
			if target.get_parent() is MeshInstance3D:
				var target_mesh = target.get_parent() as MeshInstance3D
				targetOutline.visible = true
				targetOutline.mesh = target_mesh.mesh
				targetOutline.transform = target_mesh.global_transform
				if interactClicked:
					if target_mesh.has_method("interact"):
						target_mesh.interact()
			# if target.get_parent() is EmailServer:
			# 	var server := target.get_parent() as EmailServer
			# 	targetOutline.visible = true
			# 	targetOutline.mesh = server.meshInst.mesh
			# 	targetOutline.transform = server.global_transform
			# 	if interactClicked:
			# 		server.interact()

func _physics_process(delta: float):
	# gather relevant inputs
	moveInput = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").limit_length(1.0)
	lookInput *= cameraSens * delta # mouse input is done in the _input function...
	jumpClicked = Input.is_action_just_pressed("plr_jump")
	interactClicked = Input.is_action_just_pressed("plr_interact")
	
	var conLook := Vector2(Input.get_axis("con_look_left", "con_look_right"), Input.get_axis("con_look_up", "con_look_down"))
	if(conLook.length_squared() > 0.05):
		lookInput = conLook * delta * cameraSensController
	
	# this gets set to true by the deathplane when the player collides with it
	if respawning:
		moveInput = Vector2.ZERO
		if is_on_floor():
			respawning = false
			$RespawnParticles.emitting = true

	# pre-update updates
	update_camera()
	
	# main movement code
	var wantLateralVelocity := transform.basis * Vector3(moveInput.x, 0.0, moveInput.y)
	var lateralVelocity := Vector2(velocity.x, velocity.z)
	
	var floorAccelDelta := GROUND_SPEED * delta / GROUND_ACCEL_TIME
	var floorDecelDelta := GROUND_SPEED * delta / GROUND_DECEL_TIME
	var airDelta := AIR_SPEED * delta / AIR_ACCEL_DECEL_TIME

	var onFloor = is_on_floor()

	if onFloor:
		if not prevOnGround:
			# play landing sfx
			pass
		
		if moveInput.length_squared() > 0.0005:
			lateralVelocity.x = move_toward(lateralVelocity.x, wantLateralVelocity.x * GROUND_SPEED, floorAccelDelta)
			lateralVelocity.y = move_toward(lateralVelocity.y, wantLateralVelocity.z * GROUND_SPEED, floorAccelDelta)
		else:
			lateralVelocity.x = move_toward(lateralVelocity.x, 0.0, floorDecelDelta)
			lateralVelocity.y = move_toward(lateralVelocity.y, 0.0, floorDecelDelta)

		lateralVelocity = lateralVelocity.limit_length(GROUND_SPEED)
		
		if lateralVelocity.length() > GROUND_SPEED/2:
			if footstepTimer >= FOOTSTEP_TIME:
				Wwise.post_event("PLAY_SFX_Footstep", self);
				footstepTimer = 0;
			footstepTimer = footstepTimer + delta;
		else:
			footstepTimer = FOOTSTEP_TIME + 1.0;

		if jumpClicked:
			velocity.y = JUMP_VELOCITY
			Wwise.post_event("PLAY_SFX_Jump", self)
		else:
			velocity.y = get_gravity().normalized().y
	else:
		velocity.y += get_gravity().y * delta

		# player should be able to move as fast as they can on the air (albeit with some drag when turning)
		# as they can in the air as long as they keep up some input
		if moveInput.length_squared() > 0.0005:
			lateralVelocity.x += wantLateralVelocity.x * airDelta
			lateralVelocity.y += wantLateralVelocity.z * airDelta
			lateralVelocity = lateralVelocity.limit_length(GROUND_SPEED)
		else:
			var wantClamped := lateralVelocity.limit_length(AIR_SPEED)
			lateralVelocity.x = move_toward(lateralVelocity.x, wantClamped.x, GROUND_SPEED * delta / AIR_ACCEL_DECEL_TIME)
			lateralVelocity.y = move_toward(lateralVelocity.y, wantClamped.y, GROUND_SPEED * delta / AIR_ACCEL_DECEL_TIME)

	velocity.x = lateralVelocity.x
	velocity.z = lateralVelocity.y
	
	move_and_slide()
	
	# after-update updates
	lookInput = Vector2.ZERO
	prevMoveInput = moveInput
	prevOnGround = onFloor

func respawn() -> void:
	if lastRespawnPoint == null: return
	
	respawning = true
	global_position = lastRespawnPoint.global_position
	global_position.y += RESPAWN_HEIGHT
	
	velocity.x = 0.0
	velocity.z = 0.0

func update_camera() -> void:
	cameraRef.rotation.x -= lookInput.y
	cameraRef.rotation.x = clampf(cameraRef.rotation.x, -PI / 2.0, PI / 2.0)
	rotation.y = wrapf(rotation.y - (lookInput.x), 0, 2.0 * PI)
