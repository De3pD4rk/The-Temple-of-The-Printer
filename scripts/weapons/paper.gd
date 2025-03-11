extends Area2D

@export var speed = 200
@export var damage = 15
var velocity = Vector2.ZERO  # Initial velocity
func _ready():
	await get_tree().create_timer(3).timeout
	queue_free()
	
	
func _physics_process(delta: float) -> void:
	velocity.x = speed  # Keep the horizontal speed constant
	velocity.y += gravity * delta  # Apply gravity over time
	
	# Update position with acceleration and velocity
	position += 0.5 * Vector2.DOWN * gravity * delta * delta + transform.x * speed * delta + Vector2(0, velocity.y * delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("enemies"):
	#	body.get_damage(damage)
		queue_free()
