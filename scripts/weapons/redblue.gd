extends Node2D


@onready var cooldown: Timer = $cooldown

var canUse

func _ready():
	canUse = true
	

func use():
	if canUse:
		canUse = false
		cooldown.start()
		var player = get_tree().get_first_node_in_group("Player")
		if player:
			player.activate_invulnerability(10)
		player.remove_item_from_inventory()
	
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

	if Input.is_action_just_pressed("use_item"):
		use()


func _on_cooldown_timeout() -> void:
	canUse = true
