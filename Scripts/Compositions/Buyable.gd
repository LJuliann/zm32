extends Area3D
class_name buyable

@export var price = 500
@export var interaction_area : Area3D 
@export var text_to_show : Label3D 
@export var text_outline : MeshInstance3D
var asBeenActivate = false
var canBeActivate = false
	
func _ready() -> void:
	Messanger.connect("INTERACT",interact)
	change_text()
	


func interact(points) -> void :
	pass

func _on_body_entered(body: Node3D) -> void:
	canBeActivate = true
	if(text_to_show != null):
		text_to_show.show()	
		text_outline.show()

func _on_body_exited(body: Node3D) -> void:
	canBeActivate = false
	if(text_to_show != null):
		text_to_show.hide()
		text_outline.hide()

func change_text():
	text_to_show.text = "Press F to Open Door"
