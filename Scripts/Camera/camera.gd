extends Node3D

@onready var camera_3d: Camera3D = %Camera3D
@onready var phantom_camera_3d: PhantomCamera3D = $PhantomCamera3D

@onready var can_freeze_cam = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
#	print("test")
	if can_freeze_cam:
		phantom_camera_3d.set_follow_axis_lock(PhantomCamera3D.FollowLockAxis.Z)


func _on_disconnect_camera_body_entered(body: Node3D) -> void:
	phantom_camera_3d.set_follow_axis_lock(PhantomCamera3D.FollowLockAxis.NONE)
	can_freeze_cam = false


func _on_reconnect_camera_body_entered(body: Node3D) -> void:
	phantom_camera_3d.set_follow_axis_lock(PhantomCamera3D.FollowLockAxis.NONE)


func _on_activate_disconnect_body_entered(body: Node3D) -> void:
	#print("test")
	can_freeze_cam = true


func _on_activate_disconnect_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
#	print("test")
	can_freeze_cam = true
