class_name ShotgunItem extends InventoryItem

@export var shotgun_class: PackedScene = preload("res://scenes/weapons/shotgun.tscn")
var shotgun

func use(player) -> void:
	print("sheesh")

func new_instance() -> Node2D:
	shotgun = shotgun_class.instantiate()
	return shotgun
