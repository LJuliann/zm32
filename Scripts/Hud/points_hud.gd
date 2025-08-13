extends Control

@onready var points_label: Label = $Points_Panel/Points_Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Messanger.point_hud.connect(update_point_hud)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_point_hud(points):
	points_label.text = str(points)
