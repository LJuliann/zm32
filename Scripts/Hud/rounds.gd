extends Control

@onready var round_label: Label = $Panel/Round_Label
@onready var change_round_animation: AnimationPlayer = $Change_Round_animation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Messanger.round.connect(update_round_label)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_round_label():
	change_round_animation.play("Round_change_anim")
	await get_tree().create_timer(0.8).timeout
	round_label.text = str(GameManager.round)
	
