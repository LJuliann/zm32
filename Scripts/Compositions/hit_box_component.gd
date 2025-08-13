extends Area3D
class_name hitboxComponent



@export var health_component: HealthComponent

func damage(attack):
#	print("This is Hitbox :D ")
	if health_component:
		health_component.damage(attack)
		
