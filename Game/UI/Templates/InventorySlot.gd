extends TextureRect

func get_drag_data(_pos):
	var inv_slot = get_parent().get_name()
	if PlayerAttributes.item_data[inv_slot]["Item"] != null:
		var data = {}
		data["origin_node"] = self
		data["origin_panel"] = "Inventory"
		data["origin_item_id"] = PlayerAttributes.item_data[inv_slot]["Item"]
		data["origin_equipment_slot"] = GameData.item_data[str(PlayerAttributes.item_data[inv_slot]["Item"])]["EquipmentSlot"]
		data["origin_texture"] = texture
		
		var drag_texture = TextureRect.new()
		drag_texture.expand = true
		drag_texture.texture = texture
		drag_texture.rect_size = Vector2(100,100)
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.rect_position = -0.5 * drag_texture.rect_size
		set_drag_preview(control)
		
		return data
	
func can_drop_data(_pos, data):
	var target_inv_slot = get_parent().get_name()
	if PlayerAttributes.item_data[target_inv_slot]["Item"] == null:
		data["target_item_id"] = null
		data["target_texture"] = null
		return true
	else:
		data["target_item_id"] = PlayerAttributes.item_data[target_inv_slot]["Item"]
		data["target_texture"] = texture
		if data["origin_panel"] == "CharacterSheet":
			var target_equipment_slot = GameData.item_data[str(PlayerAttributes.item_data[target_inv_slot]["Item"])]["EquipmentSlot"]
			if target_equipment_slot == data["origin_equipment_slot"]:
				return true
			else:
				return false
		else:
			return true
	


	
func drop_data(_pos, data):
	var target_inv_slot = get_parent().get_name()
	var origin_slot = data["origin_node"].get_parent().get_name()
	
	if data["origin_panel"] == "Inventory":
		PlayerAttributes.item_data[origin_slot]["Item"] = data["target_item_id"]
	else:
		PlayerAttributes.equipment_data[origin_slot] = data["target_item_id"]
		
	if data["origin_panel"] == "CharacterSheet" and data["target_item_id"] == null:
		var default_texture = load("res://Images/scroll-background.png")
		data["origin_node"].texture = default_texture
	else:
		data["origin_node"].texture = data["target_texture"]
		
	PlayerAttributes.item_data[target_inv_slot]["Item"] = data["origin_item_id"]
	texture = data["origin_texture"]
