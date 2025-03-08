extends Node2D

const BULLET = preload("res://scenes/weapons/bullet.tscn")

@onready var barrel: Marker2D = $barrel

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

	if Input.is_action_just_pressed("use_item"):
		var bullet_instance = BULLET.instantiate()
		bullet_instance.global_position = get_node("barrel").global_position
		bullet_instance.rotation = rotation
		get_tree().root.add_child(bullet_instance)
		
		
