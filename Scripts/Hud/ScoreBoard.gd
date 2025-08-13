extends Control
@onready var number_kills_label: Label = $Panel/Kills/numberKills

var number_kills : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Messanger.ennemie_dead.connect(update_kill_label)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Scoreboard"):
		show()
	else:
		hide()	

func update_kill_label():
	number_kills += 1 
	number_kills_label.text = str(number_kills)
