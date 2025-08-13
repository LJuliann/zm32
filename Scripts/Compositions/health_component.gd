extends Node3D
class_name HealthComponent


@export var MAX_HEALTH := 100

var health : float 

func _ready() -> void:
	health = MAX_HEALTH
	
func damage(attack):
	health -= attack
	#print ("this is Health :D ")
	if health <= 0:
		get_parent().queue_free()	
