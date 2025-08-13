extends HealthComponent
class_name Health_Component_Enemies

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func damage(attack):
	health -= attack
	if health <= 0:
		Messanger.ennemie_dead.emit()
		get_parent().queue_free()	
	
