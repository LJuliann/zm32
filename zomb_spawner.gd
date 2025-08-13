extends Node3D

@export var mob : PackedScene
var number_zombies_max = 1
var number_of_zombies_in_scene = 0
@onready var spawn_location: Marker3D = $Marker3D
@onready var barricade: Node3D = $Barricade
@export var is_barricade:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _spawn_zombies(): 
	var zombies = mob.instantiate()
	zombies.is_barricade = is_barricade
	zombies.position = spawn_location.position
	zombies.barricade_position = barricade
	add_child(zombies)
	


func _on_timer_timeout() -> void:
	if number_zombies_max >= number_of_zombies_in_scene:
		_spawn_zombies()
		number_of_zombies_in_scene += 1 
