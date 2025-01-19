extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity =  ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var player_mesh = $WalkerAuRework

func controller_look():
	var stick_rotation: Vector2 = Vector2(Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y), Input.get_joy_axis(0, JOY_AXIS_RIGHT_X))
	stick_rotation *= -1.0
	if stick_rotation.length() > 0.2:
		player_mesh.rotation = Basis(Vector3(0.0, 1.0, 0.0), stick_rotation.angle()).get_euler()

func mouse_look():
	var mouse_pos = get_viewport().get_mouse_position()
	var cam = get_node(".../Camera3D")
	
	var plane : Plane = Plane(Vector3.UP, 1)
	var world_pos = plane.intersects_ray(cam.project_ray_origin(mouse_pos), cam.project_ray_normal(mouse_pos))
	
	if world_pos != null:
		if world_pos == global_position:
			return
		look_at(world_pos, Vector3.UP)
	
func process():
	controller_look()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		direction += Vector3.FORWARD
	if Input.is_action_pressed("back"):
		direction += Vector3.BACK
	if Input.is_action_pressed("left"):
		direction += Vector3.LEFT
	if Input.is_action_pressed("right"):
		direction += Vector3.RIGHT
		
	direction = direction.normalized()
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	move_and_slide()

