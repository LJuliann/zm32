extends CharacterBody3D
@export var hitbox : hitboxComponent_enemy
@onready var nav: NavigationAgent3D = $NavigationAgent3D
@export var Speed = 4 
@onready var foot_step: AudioStreamPlayer3D = $FootStep

var player : Transform3D 
@onready var attack_area: Area3D = $Area3D

@export var is_barricade = true
var barricade_position = null
@onready var state_chart: StateChart = $StateChart
@onready var attack_timer: Timer = $attack_timer


var can_attack = true 
var Max_Volume = -10
var Min_Volume = -20 
var attack_target 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func damage(attack):
	if hitbox:
		hitbox.damage(attack)	

#Alaways is working. 		
func target_position(player):
	player = player
	nav.target_position = player	

#Update PathFinding to player 
func _on_timer_timeout() -> void:
	var distance = nav.distance_to_target()

	if velocity != Vector3.ZERO:
		foot_step.pitch_scale = randf_range(.5,1.2)
		foot_step.play()	
#Func to chase player. 

#Pathfinding Player 
func _chase_player():

	if(player != null):
		var next_location = nav.get_next_path_position()
		var current_location = global_transform.origin
		var new_velocity = (next_location - current_location).normalized() * Speed
		velocity = velocity.move_toward(new_velocity,0.25)
		move_and_slide()
		look_at(next_location,Vector3.UP)
	rotation.x = clampf(rotation.x,deg_to_rad(1),deg_to_rad(1))

#PathFinding To the Barricade 
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

#When the zomb is going to the barricade
func _on_navigation_agent_3d_target_reached() -> void:
	await get_tree().create_timer(5).timeout
	is_barricade = false

#When the ennemie is chasing the player 
func _on_chase_player_state_processing(delta: float) -> void:
	_chase_player()

#When the player Enter the Attacking zone 
func _on_area_3d_body_entered(body: Node3D) -> void:
	state_chart.send_event("attack_player")
	attack_target = body

#When the player exited the attacking zone 
func _on_area_3d_body_exited(body: Node3D) -> void:
	state_chart.send_event("chase_player")

#When the ennemie is attacking 
func _on_attack_player_state_processing(delta: float) -> void:
	if can_attack:
		if attack_target.has_method("get_damage"):
			attack_timer.start()
			can_attack = false

#When the ennemie Spawn. 
func _on_idle_state_processing(delta: float) -> void:
	if is_barricade:
		go_to_barricade()
	else:
		state_chart.send_event("chase_player");


func _on_attack_timer_timeout() -> void:
	print("Attacking ! ")
	attack_target.get_damage(1.0)
	can_attack = true
