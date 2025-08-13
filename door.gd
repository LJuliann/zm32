extends buyable
class_name door 

@onready var collision: RigidBody3D = $Door/RigidBody3D
@onready var model: Node3D = $Door
@onready var text: MeshInstance3D = $"../MeshInstance3D"



func _ready() -> void:
	super._ready()
	

func interact(points): 
	if canBeActivate:
		if(price <= points):
			Messanger.REMOVE_POINTS.emit(price)
			collision.queue_free()
			var animation = model.get_child(1)
			if(animation != null):
				animation.play("door-colAction")
				text.queue_free()
				
func change_text():
	text_to_show.text = "Press F To Open Door" + "[Cost " + str(price) + " ]"
