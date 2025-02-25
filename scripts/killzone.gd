extends Area2D

@onready var timer: Timer = $Timer

var stored_player: Node2D


func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	stored_player = body
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	stored_player.inventory.clear()
	Engine.time_scale = 1
	get_tree().reload_current_scene()
