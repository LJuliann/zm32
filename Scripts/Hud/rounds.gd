extends Control

@onready var round_label: Label = $Panel/Round_Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Messanger.round.connect(update_round_label)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_round_label():
	round_label.text = str(GameManager.round)
