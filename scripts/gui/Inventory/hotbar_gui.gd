extends Panel

class_name HotBar

@onready var inventory: Inventory = preload("res://scripts/gui/Inventory/inventoryPlayer.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $Selector

var key_number: int = 0
var prev_slot_content: Resource

func _ready():
	inventory.updated.connect(update)
	update()

func _process(delta: float) -> void:
	var curr_slot_content = inventory.items[key_number]
	if curr_slot_content != prev_slot_content:
		inventory.show_item_at_index(key_number)
	
	prev_slot_content = curr_slot_content
	
	
func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
	
func _input(event):
	if event is InputEventKey and event.pressed:
		var temp = event.keycode - KEY_1
		if temp >= 0 and temp < slots.size():
			key_number = temp
			select_slot(key_number)
		
func select_slot(index):
	selector.global_position = slots[index].global_position
	update()
