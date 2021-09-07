extends Control

var template_inv_slot = preload("res://Game/UI/Templates/InventorySlot.tscn")

onready var gridcontainer = get_node("Background/M/V/ScrollContainer/GridContainer")

func _ready():
	for i in PlayerAttributes.inv_data.keys():
		var inv_slot_new = template_inv_slot.instance()
		if PlayerAttributes.inv_data[i]["Item"] != null:
			var item_name = GameData.item_data[str(PlayerAttributes.inv_data[i]["Item"])]["Name"]
			var icon_texture = load("res://Images/Icon_Items/" + item_name + ".png")
			inv_slot_new.get_node("Icon").set_texture(icon_texture)
			var item_stack = PlayerAttributes.inv_data[i]["Stack"]
			if item_stack != null and item_stack > 1:
				inv_slot_new.get_node("Stack").set_text(str(item_stack))
		gridcontainer.add_child(inv_slot_new, true)
		
		

func add(itemKey, amount):
	var emptySlot
	for i in PlayerAttributes.inv_data.keys():
		if PlayerAttributes.inv_data[i]["Item"] == null:
			emptySlot = i
			break
	var inv_slot = gridcontainer.get_node(emptySlot)
	PlayerAttributes.inv_data[emptySlot]["Item"] = itemKey
	PlayerAttributes.inv_data[emptySlot]["Stack"] = amount
	var item_name = GameData.item_data[str(PlayerAttributes.inv_data[emptySlot]["Item"])]["Name"]
	var icon_texture = load("res://Images/Icon_Items/" + item_name + ".png")
	inv_slot.get_node("Icon").set_texture(icon_texture)
	var item_stack = PlayerAttributes.inv_data[emptySlot]["Stack"]
	if item_stack != null and item_stack > 1:
		inv_slot.get_node("Stack").set_text(str(item_stack))
	


func _on_Button_button_up():
	get_parent().visible = false
