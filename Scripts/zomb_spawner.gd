extends Node3D
class_name zombie_spawner

@export var mob : PackedScene

@onready var spawn_location: Marker3D = $Marker3D
@onready var barricade: Node3D = $Barricade
@export var is_barricade:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func spawn_zombies(): 
	var zombies = mob.instantiate()
	zombies.is_barricade = is_barricade
	zombies.position = spawn_location.position
	zombies.barricade_position = barricade
	add_child(zombies)
	
	
