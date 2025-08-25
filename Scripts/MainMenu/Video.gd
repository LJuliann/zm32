extends Node3D
@onready var main_menu_3d_node: Node3D = $"."

@onready var camera_3d: Camera3D = %Camera3D
@onready var animation_player: AnimationPlayer = $Anim/AnimationPlayer
@onready var little_bottom_text: Control = $World/little_bottom_text
@onready var linux_video: VideoStreamPlayer = $"Anim/Boot Video/SubViewport/VideoStreamPlayer"
@onready var main_menu: SubViewport = $"Main Menu/Sprite3D/MainMenu"
@onready var main_screen_audio: AudioStreamPlayer3D = $"Sound/MainScreen Audio"
#@onready var main_menu: SubViewport = $"Main Menu/Sprite3D/MainMenu"
@onready var main_menu_node: Node3D = $"Main Menu"

var is_main_menu = false
var is_enter_press = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("xd")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	main_menu_node.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_enter_press :
		if Input.is_anything_pressed():
			is_enter_press = true
			move_toward_arcade()
	if is_main_menu:
	#	print(main_menu.size)
		main_menu.size = get_viewport().size

func move_toward_arcade(): 
	animation_player.play("Move_Camera")
	little_bottom_text.hide()
	await get_tree().create_timer(1).timeout
	linux_video.play()
	main_screen_audio.stop()
	
	

func _on_video_stream_player_finished() -> void:
	is_main_menu = true
	main_menu_node.show()

func _input(event: InputEvent) -> void:
	if is_main_menu:
		main_menu.push_input(event)
		
