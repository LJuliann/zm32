extends CharacterBody3D
@export var hitbox : hitboxComponent_enemy
@onready var nav: NavigationAgent3D = $NavigationAgent3D
@export var Speed = 4 
@onready var foot_step: AudioStreamPlayer3D = $FootStep

var player 

@export var is_barricade = true
var barricade_position = null

var Max_Volume = -10
var Min_Volume = -20 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_barricade:
		go_to_barricade()
	else:
		chase_player()	


func damage(attack):
	if hitbox:
		hitbox.damage(attack)	
		
func target_position(player):
	player = player
	nav.target_position = player	
	#print(player)

func _on_timer_timeout() -> void:
	var distance = nav.distance_to_target()

	if velocity != Vector3.ZERO:

		foot_step.pitch_scale = randf_range(.5,1.2)
		foot_step.play()	

func chase_player():
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * Speed
	velocity = velocity.move_toward(new_velocity,0.25)
	move_and_slide()
	look_at(next_location,Vector3.UP)
	rotation.x = clampf(rotation.x,deg_to_rad(1),deg_to_rad(1))

func go_to_barricade():
	if is_barricade: 
		nav.target_position = barricade_position.global_transform.origin
		var next_location = nav.get_next_path_position()
		var current_location = global_transform.origin
		var new_velocity = (next_location - current_location).normalized() * Speed
		velocity = velocity.move_toward(new_velocity,0.25)
		move_and_slide()
		look_at(next_location,Vector3.UP)
		rotation.x = clampf(rotation.x,deg_to_rad(1),deg_to_rad(1))
		nav.target_reached

func _on_navigation_agent_3d_target_reached() -> void:
	await get_tree().create_timer(5).timeout
	is_barricade = false
