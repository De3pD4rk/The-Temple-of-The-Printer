extends "res://scripts/collectables/collectable.gd"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
var stored_inventory: Inventory

func collect(inventory: Inventory):
	stored_inventory = inventory
	animated_sprite_2d.speed_scale = 5
	timer.start()

func _on_timer_timeout() -> void:
	animated_sprite_2d.speed_scale = 1
	print("Coin collected")
	super.collect(stored_inventory)
