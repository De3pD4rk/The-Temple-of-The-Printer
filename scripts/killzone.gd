extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("You died!")
		Global.death_counter += 1
		body.inventory.clear()
		get_tree().reload_current_scene()
