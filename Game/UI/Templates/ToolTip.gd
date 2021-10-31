extends Popup

var origin = ""
var slot = ""
var valid = false

func _process(delta):
	if(GameData.inventoryVisible == false):
		queue_free()

func _ready():
	var item_id
	if origin == "Inventory":
		if PlayerAttributes.inv_data[slot]["Item"] != null:
			item_id = str(PlayerAttributes.inv_data[slot]["Item"])
			valid = true
	else:
		if PlayerAttributes.equipment_data[slot] != null:
			item_id = str(PlayerAttributes.equipment_data[slot])
			valid = true
		
	if valid:
		get_node("N/M/V/ItemName").set_text(GameData.item_data[item_id]["Name"])
		var item_stat = 1
		for i in range(GameData.item_stats.size()):
			var stat_name = GameData.item_stats[i]
			var stat_label = GameData.item_stat_labels[i]
			if GameData.item_data[item_id][stat_name] != null:
				var stat_value = GameData.item_data[item_id][stat_name]
				get_node("N/M/V/Stat" + str(item_stat) + "/Stat").set_text(stat_label + ": " + str(stat_value))
				
				if GameData.item_data[item_id]["EquipmentSlot"] != null and origin == "Inventory":
					var stat_difference = CompareItems(item_id, stat_name, stat_value)
					get_node("N/M/V/Stat" + str(item_stat) + "/Difference").set_text("  " + str(stat_difference))
					if stat_difference > 0:
						get_node("N/M/V/Stat" + str(item_stat) + "/Difference").modulate = Color("3eff00")
					elif stat_difference < 0:
						get_node("N/M/V/Stat" + str(item_stat) + "/Difference").modulate = Color("ff0000")
				
				item_stat += 1
				
func CompareItems(item_id, stat_name, stat_value):
	var stat_difference
	var equipment_slot = GameData.item_data[item_id]["EquipmentSlot"]
	if PlayerAttributes.equipment_data[equipment_slot] != null:
		var item_id_current = PlayerAttributes.equipment_data[equipment_slot]
		var stat_value_current = GameData.item_data[str(item_id_current)][stat_name]
		stat_difference = stat_value - stat_value_current
	else:
		stat_difference = stat_value
	return stat_difference
