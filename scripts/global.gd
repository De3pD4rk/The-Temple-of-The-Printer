extends Node

var death_counter: int = 0
var playtime: float = 0.0
var coins: int = 0
var kills: int = 0

func _process(delta: float) -> void:
	playtime += delta
