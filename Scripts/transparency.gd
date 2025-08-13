extends Node
@export var Player : CharacterBody3D
@export var camera : Camera3D
@onready var csg_box_3d_2: CSGBox3D = $NavigationRegion3D/CSGBox3D2
@onready var csg_box_3d_5: CSGBox3D = $NavigationRegion3D/CSGBox3D5

@export var wall_array: Array[Node] = []
@export var door_array: Array[Node] = []

@onready var marker_3d: Marker3D = $"../Door/Marker3D"

@export var min_distance = 7 
var distance 
#var wall_array = Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var distance_ultra_test 
	var distance_v2 = Vector2.ZERO
	if(wall_array != null):
		for i in wall_array:	
			distance = (camera.global_position.z - i.position.z)
			#distance = (i.position.z - camera.global_position.z)
			distance_ultra_test	= (clamp(distance,-min_distance,0)) / min_distance 
		
			print(distance_ultra_test)
		
			
func _pass():
	pass
#		var tween = create_tween()
#	var distance_ultra_test 
#	var distance_v2 = Vector2.ZERO
#	if(wall_array != null):
#		for i in wall_array:	
#			#distance = (camera.global_position.z - i.position.z)
#			distance = (i.position.z - camera.global_position.z)
#			#distance_ultra_test	= abs(clamp(distance,-min_distance,0)) / min_distance 
#	
#	var	distance_door			
#	if(door_array != null):
#		for i in door_array:
#			distance_door = i.position.x - camera.global_position.x	
#			distance_v2 = Vector2(marker_3d.global_position.x, marker_3d.global_position.z).normalized()
#			#distance_ultra_test = clam  
#			distance_ultra_test = distance_v2.distance_to(Vector2(camera.global_position.x,camera.global_position.z).normalized()) *2 
#			print(distance_ultra_test)
#	
#	if(distance_v2 > Vector2.ZERO):
#		for i in wall_array:
#			i.transparency = 1
#	else:
#		for i in wall_array:
#			i.transparency = 1 - distance_ultra_test 
