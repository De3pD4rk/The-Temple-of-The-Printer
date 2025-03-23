extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not body.is_invulnerable:
		Global.death_counter += 1
		Global.kills = 0
		body.inventory.clear()
		get_tree().reload_current_scene()
