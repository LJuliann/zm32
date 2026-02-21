extends Node
@export var Player : CharacterBody3D
@export var camera : Camera3D
@onready var csg_box_3d_2: CSGBox3D = $NavigationRegion3D/CSGBox3D2
@onready var csg_box_3d_5: CSGBox3D = $NavigationRegion3D/CSGBox3D5

@export var wall_array: Array[Node] = []
@export var door: Node3D 
@onready var transparency_shape: CollisionShape3D = $"../Door/Transparency_trigger/Transparency_Shape"

@onready var is_active = false 


@export var min_distance = 7 
var distance 
#var wall_array = Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_active:
		transparency_backup()
	

func transparency_backup(): 
		
	distance = camera.global_position.z - door.global_position.z
	#print(distance / 100)
	
	#if distance < 0: 
	#	for i in wall_array:
	#		i.transparency = 1
	#else:
	#	for i in wall_array: 
	#		i.transparency = -distance / 100
	
func _on_transparency_trigger_body_entered(_body: Node3D) -> void:
	is_active = true


func _on_transparency_trigger_body_exited(_body: Node3D) -> void:
	is_active = false
