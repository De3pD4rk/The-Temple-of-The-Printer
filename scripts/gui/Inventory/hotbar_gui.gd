extends HBoxContainer

@onready var inventory: Inventory = preload("res://scripts/gui/Inventory/inventoryPlayer.tres")
@onready var slots: Array = $".".get_children()

func _ready():
	inventory.updated.connect(update)
	update()
	

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
	
