extends "res://scripts/collectables/collectable.gd"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

signal coin_collected

func collect(inventory: Inventory):
	animated_sprite_2d.speed_scale = 5
	timer.start()
	

func _on_timer_timeout() -> void:
	print("Coin collected!")
	coin_collected.emit()
	animated_sprite_2d.speed_scale = 1
	queue_free()
