extends Node3D
@onready var cirlce_fill: Node3D = $Cirlce_fill
@export var Player : CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	cirlce_fill.global_position = Player.global_position + Vector3(-1.2,1.2,0)
