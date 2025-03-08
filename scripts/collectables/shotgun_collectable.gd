extends "res://scripts/collectables/collectable.gd"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func collect(inventory: Inventory):
	print("Shotgun collected")
	super.collect(inventory)
