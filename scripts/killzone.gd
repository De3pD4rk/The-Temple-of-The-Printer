extends Area2D

@onready var timer: Timer = $Timer

var stored_body: Node2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("You died!")
		stored_body = body
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		timer.start()

func _on_timer_timeout() -> void:
	stored_body.inventory.clear()
	Engine.time_scale = 1
	get_tree().reload_current_scene()
