extends Area2D

@export var itemRes: InventoryItem

func collect(inventory: Inventory):
	print("IDK")
	inventory.insert(itemRes)
	queue_free()
