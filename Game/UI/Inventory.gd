extends Control

var template_inv_slot = preload("res://Game/UI/Templates/InventorySlot.tscn")

onready var gridcontainer = get_node("Background/M/V/ScrollContainer/GridContainer")

func _ready():
	for i in PlayerAttributes.item_data.keys():
		var inv_slot_new = template_inv_slot.instance()
		if PlayerAttributes.item_data[i]["Item"] != null:
			var item_name = GameData.item_data[str(PlayerAttributes.item_data[i]["Item"])]["Name"]
			var icon_texture = load("res://Images/Icon_Items/" + item_name + ".png")
			inv_slot_new.get_node("Icon").set_texture(icon_texture)
		gridcontainer.add_child(inv_slot_new, true)
