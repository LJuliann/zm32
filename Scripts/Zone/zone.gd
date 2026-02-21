extends Node3D
class_name zone

@export var is_active:bool = false
@export var zomb_spawn:Array[zombie_spawner]
@onready var zomb_spawner: zombie_spawner = $Zomb_Spawner


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func spawn_zombie(_asd):
	if is_active:
		if zomb_spawn != null:	
			var zomb_spawner_random_number = (randi_range(0,zomb_spawn.size() - 1))
			zomb_spawn.get(zomb_spawner_random_number).spawn_zombies()
			
