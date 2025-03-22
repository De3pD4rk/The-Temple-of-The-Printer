extends Control

func _on_play_pressed() -> void:
	print("here")
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_help_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
