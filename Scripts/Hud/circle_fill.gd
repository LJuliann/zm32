extends Node3D
@onready var texture_progress_bar: TextureProgressBar = $SubViewport/TextureProgressBar
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Messanger.circle_fill.connect(progress_bar)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func progress_bar(time:float): 
	texture_progress_bar.value = 0
	texture_progress_bar.show()
	tween = create_tween()
	tween.tween_property(texture_progress_bar,"value",100,time)
	await tween.finished 
	await get_tree().create_timer(0.1).timeout
	texture_progress_bar.hide()
	
