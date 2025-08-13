extends Area3D
class_name hitboxComponent_enemy
@onready var model: MeshInstance3D = $"../Model"
@onready var hit_anim: AnimationPlayer = $"../Model/hit_anim"

@export var health_component: HealthComponent

func damage(attack):
#	print("This is Hitbox :D ")
	if health_component:
		health_component.damage(attack)
		hit_anim.play("Hit")
