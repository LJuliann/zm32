extends Control

@onready var clip_size: Label = $Panel/ClipSize
@onready var ammo_size: Label = $Panel/AmmoSize
@onready var weapon_name: Label = $"Panel/Weapon Name"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Messanger.weapon_name_hud.connect(update_weapon_name)
	Messanger.weapon_ammoSize_hud.connect(update_ammo_size)
	Messanger.weapon_clipSize_hud.connect(update_clip_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_clip_size(clipSize):
	clip_size.text = str(int(clipSize))
	if clipSize > 3: 
		clip_size

func update_ammo_size(ammoSize):
	ammo_size.text = "/" + str(int(ammoSize))

func update_weapon_name(name):
	weapon_name.text = name.to_upper()		
