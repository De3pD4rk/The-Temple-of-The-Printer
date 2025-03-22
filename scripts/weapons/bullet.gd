extends Area2D

@export var speed = 200
@export var damage = 15

func _ready():
	await get_tree().create_timer(3).timeout
	queue_free()
	
	
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.get_damage(damage)
	queue_free()
