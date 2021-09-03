extends Node2D

export(float) var item
export(float) var amount


func open():
	PlayerAttributes.addInventoryItem(item, amount)
	queue_free()
