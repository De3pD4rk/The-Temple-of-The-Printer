extends CharacterBody2D

const SPEED = 60

var direction = 1
var health_points = 1
var is_stunned = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stun_timer: Timer = $Stun_Timer

func _ready():
	stun_timer.wait_time = 2
	start_movement_cycle()

func _physics_process(delta: float) -> void:
	if not is_stunned:
		velocity.x = SPEED * direction
	else:
		velocity.x = 0  # Stop movement when stunned

	move_and_slide()

func start_movement_cycle():
	while true:
		await get_tree().create_timer(2.0).timeout  # Wait 2 seconds
		if not is_stunned:
			direction *= -1
			animated_sprite.flip_h = !animated_sprite.flip_h

func get_damage(damage: int):
	health_points -= damage
	if health_points <= 0:
		die()

func die():
	queue_free()


func stun():
	is_stunned = true
	animated_sprite.pause()
	stun_timer.start()

func _on_stun_timer_timeout() -> void:
	is_stunned = false
	animated_sprite.play()
