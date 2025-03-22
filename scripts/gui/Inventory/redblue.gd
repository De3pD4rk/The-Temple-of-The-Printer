class_name RedBlueItem extends InventoryItem

@export var redblue_class: PackedScene = preload("res://scenes/weapons/redblue.tscn")
var redblue

func new_instance() -> Node2D:
	redblue = redblue_class.instantiate()
	return redblue
