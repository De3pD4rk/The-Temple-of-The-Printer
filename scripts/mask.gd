extends CharacterBody2D

@export var speed: float = 60
@export var flip_x: bool = false  # Exported variable to control Y flip

var direction = 1
var health_points = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

func _ready():
	timer.wait_time = 2
	animated_sprite.flip_h = flip_x  # Apply the flip setting at start

func get_damage(damage: int):
	health_points -= damage
	if health_points <= 0:
		die()

func die():
	Global.kills += 1
	queue_free()

func stun():
	animation_player.pause()
	timer.start()

func _on_timer_timeout() -> void:
	animation_player.play()
