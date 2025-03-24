extends CharacterBody2D

@export var speed: float = 60
@export var wait: float = 2.0

var direction = 1
var health_points = 1
var is_stunned = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stun_timer: Timer = $Stun_Timer
@onready var movement_timer: Timer = $Movement_Timer  # Add a new timer in the scene

func _ready():
	stun_timer.wait_time = 2
	movement_timer.wait_time = wait  # Set movement timer interval
	movement_timer.start()  # Start the timer to begin movement cycle

func _physics_process(delta: float) -> void:
	if not is_stunned:
		velocity.x = speed * direction
	else:
		velocity.x = 0  # Stop movement when stunned

	move_and_slide()

func _on_movement_timer_timeout() -> void:
	if is_stunned:
		return  # Do nothing if stunned
	direction *= -1
	animated_sprite.flip_h = !animated_sprite.flip_h
	movement_timer.start()  # Restart the movement timer

func get_damage(damage: int):
	health_points -= damage
	if health_points <= 0:
		die()

func die():
	Global.kills += 1
	queue_free()

func stun():
	is_stunned = true
	animated_sprite.pause()
	stun_timer.start()
	movement_timer.paused = true  # Pause movement timer when stunned

func _on_stun_timer_timeout() -> void:
	is_stunned = false
	animated_sprite.play()
	movement_timer.paused = false  # Resume movement timer after stun
