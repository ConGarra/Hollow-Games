extends Area2D

@export var itemRes : InventaryItem

func collect(inventary: Inventory):
	inventary.insert(itemRes)
	queue_free()

