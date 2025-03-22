extends Control

var _is_paused = false:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_is_paused = !_is_paused

func _on_button_pressed() -> void:
	_is_paused = false

func _on_main_menu_pressed() -> void:
	_is_paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
