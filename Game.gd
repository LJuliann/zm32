extends Node3D
@onready var player: CharacterBody3D = %Player



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().call_group("enemy","target_position",player.global_transform.origin)


func _on_zone_body_entered(body: Node3D, extra_arg_0: String) -> void:
	pass # Replace with function body.
