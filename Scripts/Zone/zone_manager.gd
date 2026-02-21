extends Node3D
@export var zone:Array[zone]

var active_zone:Array[zone]

var main_zone
var side_zone
var max_enemies_per_hoard = 32
var max_enemies_per_round = 10
var spawn_delay = 2
var enemies_alive = 0 
var total_enemies = 0
var is_round_pause = false
var number_of_zone_active = 0
var limit_number_of_zone = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Messanger.ennemie_dead.connect(zomb_dead)
	
	max_enemies_per_hoard = GameManager.max_enemies_per_hoard
	max_enemies_per_round = GameManager.max_enemies_per_round

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	check_end_round()
	

func _on_zone_body_entered(_body: Node3D, extra_arg_0: String) -> void:
	#print(extra_arg_0)
	for i in zone:
		if i.name == extra_arg_0:

			check_array(i)
			
			if	i.has_method("spawn_zombie"):
				i.is_active = true
				
				number_of_zone_active += 1 


func GameRule(): 
	if ! is_round_pause:	
		if enemies_alive < max_enemies_per_hoard:
			if total_enemies < max_enemies_per_round:
				var zomb_spawner_random_number = (randi_range(0,active_zone.size() - 1))
				active_zone.get(zomb_spawner_random_number).spawn_zombie("test")
				enemies_alive += 1
				total_enemies += 1 
		#		print(active_zone.size())

func _on_spawn_timer_timeout() -> void:
	
		GameRule()

func zomb_dead():
	enemies_alive -= 1 

func check_end_round(): 
	if ! is_round_pause:		
		if total_enemies == max_enemies_per_round:
			if enemies_alive == 0:
			#	print("end Round")
				change_round()
				is_round_pause = true

func change_round(): 
	GameManager.round += 1
	max_enemies_per_round += 1 
	total_enemies = 0
	Messanger.round.emit()
#	print(GameManager.round)
	await get_tree().create_timer(GameManager.delay_between_round).timeout
	is_round_pause = false

func check_array(i):

	#print(i)
	var can_add = true
	for z in active_zone:
		if z == i:
			var temp_zone = active_zone.find(z)
		#	print(active_zone)
			can_add = false
			
	active_zone.push_back(i)   
	#	
	
	if active_zone.size() > limit_number_of_zone:
		active_zone.pop_front()
	#	
