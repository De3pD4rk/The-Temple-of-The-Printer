class_name PrinterItem extends InventoryItem

@export var printer_class: PackedScene = preload("res://scenes/weapons/printer.tscn")
var printer

func new_instance() -> Node2D:
	printer = printer_class.instantiate()
	return printer
