extends Panel

@onready var inventory: Inventory = preload("res://scripts/gui/Inventory/inventoryPlayer.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $Selector

var selected_slot_index: int = 0

func _ready():
	inventory.updated.connect(update)
	update()
	

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
	
func _input(event):
	if event is InputEventKey and event.pressed:
		var key_number = event.keycode - KEY_1
		if key_number >= 0 and key_number < slots.size():
			select_slot(key_number)
	if event.is_action_pressed("use_item"):
		inventory.use_item_at_index(selected_slot_index)



func select_slot(index):
	selected_slot_index = index
	selector.global_position = slots[selected_slot_index].global_position
	update()
