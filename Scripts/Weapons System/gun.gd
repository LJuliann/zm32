extends Node3D
@onready var marker_3d: Marker3D = $Marker3D
@onready var shape_cast_3d: ShapeCast3D = $ShapeCast3D
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var stats : Array[weapons_stats] = []
var weapons : Array[weapons_stats] = []
var current_weapon : weapons_stats
var weapon_slot : int
var total_weapon_slot :int 

var limit_number_weapon = 2 
var weapon_switching_dalay : int


var damage	:	float
var bulletSpeed	:	float
var fireRate	:	float
var delayBetweenShot : float
var isAutomatic : bool
var isHitScan : bool
var clipSize : float 
var ammoSize : float
var reloadSpeed : float

var canShoot : bool = true
var canReload: bool = true
var canSwitchWeapon: bool = false

var points_hit_made = -50

@onready var reload_label: Label3D = $Label3D
@onready var sound_effect: AudioStreamPlayer3D = $gunShot

@onready var blink_anim: AnimationPlayer = $Label3D/Blink_anim
var min_before_hud = 4



#const BULLET = preload("res://Scenes/Weapons/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Messanger.cooldown.connect(cooldown)
	
	weapon_slot = 0
	
	var weapon1 = weapons_stats.new()
	weapon1 = stats.get(0).duplicate()
	weapons.append(weapon1)
	
	#var weapon2 = weapons_stats.new()

	#weapon2 = stats.get(1).duplicate()
	#weapons.append(weapon2)
	current_weapon = weapons.get(0)

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(current_weapon.isAutomatic):
		if Input.is_action_pressed("Shoot"):
			shootAutomatic()
	else:
		if Input.is_action_just_pressed("Shoot"):
			_shoot()
			
	if Input.is_action_just_pressed("Reload"):	
		_reload()	
	
	if Input.is_action_just_pressed("SwitchWeapon"):
		switchWeapon()	
	
	
	updateHUD()	
	_hud_reload()

func _shoot():
	#Manage Weapon 
	can_shoot()
	if current_weapon.clipSize > 0 and canShoot : 
		
		current_weapon.clipSize -= 1
		AudioManager.play(current_weapon.gunShotSound)
		
		#If hit 
	#	if(shape_cast_3d.is_colliding()):
	#		if shape_cast_3d.get_collider(0).has_method("damage"):
	#			shape_cast_3d.get_collider(0).damage(current_weapon.damage)
	#			Messanger.REMOVE_POINTS.emit(points_hit_made)
	#
	#	print(ray_cast_3d.get_collider())
		if ray_cast_3d.is_colliding():		
			if ray_cast_3d.get_collider().has_method("damage"):
				ray_cast_3d.get_collider().damage(current_weapon.damage)
				Messanger.REMOVE_POINTS.emit(points_hit_made)
				
func shootAutomatic():
		#Manage Weapon 
	if(canShoot):
		_shoot()
		canShoot = false
		timerRate()

func timerRate():
	await get_tree().create_timer(current_weapon.fireRate).timeout
	canShoot = true 

func _reload():
	if canReload:
		if(current_weapon.clipSize != stats.get(weapon_slot).clipSize ):
			if (current_weapon.ammoSize > 0 ):
				AudioManager.play("res://Assets/SoundEffect/reload.mp3")
				var bullet_needed_clip = stats.get(weapon_slot).clipSize - current_weapon.clipSize
	
				if bullet_needed_clip >= current_weapon.ammoSize:
					canShoot = false
					Messanger.circle_fill.emit(current_weapon.reloadSpeed)
					#gun_sound_effect.stream = current_weapon.gunShotSound
					await get_tree().create_timer(current_weapon.reloadSpeed).timeout
					current_weapon.clipSize = current_weapon.ammoSize
					current_weapon.ammoSize -= bullet_needed_clip
					canShoot = true
				
				else:
					canShoot = false
				#gun_sound_effect.stream = current_weapon.gunShotSound
					Messanger.circle_fill.emit(current_weapon.reloadSpeed)
					await get_tree().create_timer(current_weapon.reloadSpeed).timeout
					current_weapon.clipSize += bullet_needed_clip	
					current_weapon.ammoSize -= bullet_needed_clip
					canShoot = true
				
			if current_weapon.ammoSize < 0:
				current_weapon.ammoSize = 0
				
		can_shoot()	

func switchWeapon():
	
	if(weapons.size() > 1):
		total_weapon_slot = weapons.size() - 1 
		
		if weapon_slot < total_weapon_slot:
			weapon_slot += 1
		else:
			weapon_slot = 0	 
		current_weapon = weapons.get(weapon_slot)
		print(current_weapon.clipSize)

func updateHUD(): 
		Messanger.weapon_name_hud.emit(current_weapon.name)
		Messanger.weapon_clipSize_hud.emit(current_weapon.clipSize)
		Messanger.weapon_ammoSize_hud.emit(current_weapon.ammoSize)

func _hud_reload(): 
	if current_weapon.clipSize < min_before_hud :
		reload_label.show()
		blink_anim.play("blink")
	if current_weapon.clipSize >= min_before_hud: 
		reload_label.hide()
		blink_anim.stop()
		

func play_sound():
		pass

func can_shoot(): 
	if(current_weapon.clipSize <= 0):
		canShoot = false
	else:
		canShoot = true
			
func cooldown(cooldown_time): 
	var temp_reload = canReload
	var temp_shoot = canShoot
	canReload = false
	canShoot = false
	await get_tree().create_timer(cooldown_time).timeout
	canReload = temp_reload
	canShoot = temp_shoot
	
