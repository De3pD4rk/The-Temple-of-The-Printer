extends Node2D

const SPEED = 60

var direction = 1
var health_points = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func get_damage(damage: int):
	health_points -= damage
	if health_points <= 0:
		die()

func die():
	queue_free()
