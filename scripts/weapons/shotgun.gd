extends Node2D

const BULLET = preload("res://scenes/weapons/bullet.tscn")

@onready var barrel: Marker2D = $barrel
@onready var shootspeed_timer: Timer = $shootspeed

@export var shootSpeed = 1.0

var canShoot = true

func _ready():
	shootspeed_timer.wait_time = 1.0/shootSpeed
	

func shoot():
	if canShoot:
		print("yea yeah")
		canShoot = false
		shootspeed_timer.start()
		var bullet_instance = BULLET.instantiate()
		bullet_instance.global_position = get_node("barrel").global_position
		bullet_instance.rotation = rotation
		get_tree().root.add_child(bullet_instance)
	
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

	if Input.is_action_just_pressed("use_item"):
		print("yeah")
		shoot()

func _on_shootspeed_timeout() -> void:
	canShoot = true
