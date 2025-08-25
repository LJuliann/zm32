extends Control

@onready var play: Button = %Play


@onready var settings: Button = %Settings

@onready var quit: Button = %Quit

@onready var animation_player: AnimationPlayer = $Panel/AnimationPlayer
@onready var settings_player: AnimationPlayer = %SettingsPlayer
@onready var quit_player: AnimationPlayer = $QuitPlayer

var is_animation = true


func _ready() -> void:
	play.grab_focus()
	play.mouse_filter = Control.MOUSE_FILTER_IGNORE
	settings.mouse_filter = Control.MOUSE_FILTER_IGNORE
	quit.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().change_scene_to_file("res://Scenes/loading_screen.tscn")

func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_play_focus_entered() -> void:
	animation_player.play("PlaySlide")
	

func _on_play_focus_exited() -> void:
	animation_player.play_backwards("PlaySlide")

func _on_settings_focus_entered() -> void:
	settings_player.play("OptionsSlide")

func _on_settings_focus_exited() -> void:
	settings_player.play_backwards("OptionsSlide")

func _on_quit_focus_entered() -> void:
	quit_player.play("QuitSlide")

func _on_quit_focus_exited() -> void:
	quit_player.play_backwards("QuitSlide")
