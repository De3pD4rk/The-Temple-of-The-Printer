extends "res://scripts/collectables/collectable.gd"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func collect():
	animation_player.play("pickup")
	await animation_player.animation_finished
	print("Shotgun collected")
	super.collect()
