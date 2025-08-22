extends Node3D
class_name zone

@export var is_active:bool = false
@export var zomb_spawn:Array[zombie_spawner]
@onready var zomb_spawner: zombie_spawner = $Zomb_Spawner


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_zombie(asd):
	if is_active:
		if zomb_spawn != null:	
			zomb_spawn.get(0).spawn_zombies()
			#print(zomb_spawn)
