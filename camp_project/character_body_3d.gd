extends CharacterBody3D


@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	pass


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var z = 0

	if Input.is_action_pressed("forward"):
		z = -1
	elif Input.is_action_pressed("backward"):
		z = 1
		
	if Input.is_action_pressed("turn_left"):
		rotation.y = rotation.y + deg_to_rad(15)*delta
	elif Input.is_action_pressed("turn_right"):
		rotation.y = rotation.y - deg_to_rad(15)*delta
		
	
	var direction = (transform.basis * Vector3(0, 0, z)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
