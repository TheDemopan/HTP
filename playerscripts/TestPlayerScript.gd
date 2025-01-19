extends CharacterBody3D

@export var speed: float = 10.0
@onready var camera = $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Get input for movement and rotation
	var movement_direction: Vector2 = Vector2(Input.get_joy_axis(0, JOY_AXIS_LEFT_X), Input.get_joy_axis(0, JOY_AXIS_LEFT_Y))
	var rotation_direction: Vector2 = Vector2(Input.get_joy_axis(0, JOY_AXIS_RIGHT_X), Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y))

	# Process movement input (dead zone handling and smoothing can be added here)
	if movement_direction.length() > 0.1:
		var player_direction = Vector3(movement_direction.x, 0, movement_direction.y).normalized()
		velocity.x = player_direction.x * speed
		velocity.z = player_direction.z * speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	# Process rotation input (dead zone handling and smoothing can be added here)
	if rotation_direction.length() > 0.1:
		var target_rotation = Vector3(rotation_direction.x, 0, rotation_direction.y).normalized()
		look_at(global_transform.origin + target_rotation, Vector3.UP)

	move_and_slide()
