extends Node3D
@onready var mele_radius: ShapeCast3D = $ShapeCast3D
@onready var mele_ray_cast: RayCast3D = $ShapeCast3D/mele_ray_cast
@export var cooldown = 1

@export var points_made = -150

var can_mele = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mele_attack"):
		_mele_attack()
		

func _mele_attack():
	if can_mele:	
		if mele_ray_cast.is_colliding():
			if mele_ray_cast.get_collider().has_method("damage"):
				mele_ray_cast.get_collider().damage(100)
				Messanger.REMOVE_POINTS.emit(points_made)
				_cool_down()
				
func _cool_down():
	Messanger.circle_fill.emit(cooldown)
	can_mele = false
	await get_tree().create_timer(cooldown).timeout
	can_mele = true
