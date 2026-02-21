extends CharacterBody3D

var health : float = 100.0
var points = 500
const SPEED = 5.0
@export var is_movement_absolute = false
const CURSOR = preload("res://Assets/Cursor/cursor 1.png")
const Cursor2 = preload("res://Assets/Cursor/cursor 2.png")

@onready var model: MeshInstance3D = $MeshInstance3D
#@onready var camRad: Area3D = $Area3D

@onready var cam: Camera3D = %Camera3D


var RAY_LENGTH = 2000

func _ready() -> void:
	Messanger.connect("REMOVE_POINTS",remove_points)
	Input.set_custom_mouse_cursor(CURSOR,Input.CURSOR_ARROW,Vector2(32,32))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("interact"):
		Messanger.INTERACT.emit(points)

	# Get the input direction and handle the movement/deceleration.
	movement()	
	model.look_at(ScreenPointToRay(),Vector3.UP)
	model.rotation.x = clampf(rotation.x,deg_to_rad(1),deg_to_rad(1))
	rotation.x = clampf(rotation.x,deg_to_rad(1),deg_to_rad(1))

	cursor_animation()
	
func movement() -> void:
	if(is_movement_absolute): 
		var input_dir := Input.get_vector("mLeft", "mRight", "mForward", "mBackward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)	
		move_and_slide()
	else:
		var input_vector = Vector3.ZERO
		input_vector.z = Input.get_action_strength("mBackward") - Input.get_action_strength("mForward")
		input_vector.x = Input.get_action_strength("mRight") - Input.get_action_strength("mLeft")
		input_vector.normalized()
		velocity = input_vector * SPEED
		move_and_slide()		

func ScreenPointToRay():
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	

	var rayArray = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(origin,end ))
	if rayArray.has("position"):
		return rayArray.get("position")
	return Vector3()	

func remove_points(points_in):
	points -= points_in
	#print(points)
	Messanger.point_hud.emit(points)

func cursor_animation():
	if(velocity != Vector3.ZERO):
		Input.set_custom_mouse_cursor(Cursor2,Input.CURSOR_ARROW,Vector2(32,32))
	else:
		Input.set_custom_mouse_cursor(CURSOR,Input.CURSOR_ARROW,Vector2(32,32))	

func get_damage(damage : float): 
	health -= damage
	print(health)
