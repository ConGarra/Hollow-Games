extends Area2D

@export var itemRes : InventoryItem

func collect(inventary: Inventory):
	inventary.insert(itemRes)
	queue_free()

