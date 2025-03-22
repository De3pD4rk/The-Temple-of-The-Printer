extends Resource

class_name Inventory

signal updated
signal use_item
signal show_item

@export var items: Array[InventoryItem]

func insert(item: InventoryItem):
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			break
	updated.emit()
	
func clear():
	for i in range(1, items.size()):
		items[i] = null
	updated.emit()

func isFull():
	for i in range(items.size()):
		if items[i] == null:
			return false
	return true

func use_item_at_index(index: int) -> void:
	var slot = items[index]
	if not slot == null:
		use_item.emit(slot)

func show_item_at_index(index:int) -> void:
	var slot = items[index]
	show_item.emit(slot)

func remove(item: InventoryItem):
	for i in range(items.size()):
		if items[i] == item:
			items[i] = null
			updated.emit()
			break
