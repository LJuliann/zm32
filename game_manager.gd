extends Node3D

@onready var player: CharacterBody3D = %Player

@export var max_enemies_per_hoard = 32 
@export var max_enemies_per_round = 3
@onready var round = 1 
@export var total_zombies_in_round = 7 
@export var delay_between_round = 2

var enemies_alive 
var enemies_remainig 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
#	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



	
