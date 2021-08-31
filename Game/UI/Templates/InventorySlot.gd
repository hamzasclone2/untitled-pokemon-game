extends TextureRect

onready var tool_tip = preload("res://Game/UI/Templates/ToolTip.tscn")

func get_drag_data(_pos):
	var inv_slot = get_parent().get_name()
	if PlayerAttributes.item_data[inv_slot]["Item"] != null:
		var data = {}
		data["origin_node"] = self
		data["origin_panel"] = "Inventory"
		data["origin_item_id"] = PlayerAttributes.item_data[inv_slot]["Item"]
		data["origin_equipment_slot"] = GameData.item_data[str(PlayerAttributes.item_data[inv_slot]["Item"])]["EquipmentSlot"]
		data["origin_stackable"] = GameData.item_data[str(PlayerAttributes.item_data[inv_slot]["Item"])]["Stackable"]
		data["origin_stack"] = PlayerAttributes.item_data[inv_slot]["Stack"]
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
		data["target_stack"] = null
		return true
	else:
		data["target_item_id"] = PlayerAttributes.item_data[target_inv_slot]["Item"]
		data["target_texture"] = texture
		data["target_stack"] = PlayerAttributes.item_data[target_inv_slot]["Stack"]
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
	
	if data["target_item_id"] == data["origin_item_id"] and data["origin_stackable"] == true:
		PlayerAttributes.item_data[origin_slot]["Item"] = null
		PlayerAttributes.item_data[origin_slot]["Stack"] = null
	elif data["origin_panel"] == "Inventory":
		PlayerAttributes.item_data[origin_slot]["Item"] = data["target_item_id"]
		PlayerAttributes.item_data[origin_slot]["Stack"] = data["target_stack"]
	else:
		PlayerAttributes.equipment_data[origin_slot] = data["target_item_id"]
		
	if data["target_item_id"] == data["origin_item_id"] and data["origin_stackable"] == true:
		data["origin_node"].texture = null
		data["origin_node"].get_node("../Stack").set_text("")
	elif data["origin_panel"] == "CharacterSheet" and data["target_item_id"] == null:
		var default_texture = load("res://Images/Icon_Items/" + origin_slot + "_Outline.png")
		data["origin_node"].texture = default_texture
	else:
		data["origin_node"].texture = data["target_texture"]
		if data["target_stack"] != null and data["target_stack"] > 1:
			data["origin_node"].get_node("../Stack").set_text(str(data["target_stack"]))
		elif data["origin_panel"] == "Inventory":
			data["origin_node"].get_node("../Stack").set_text("")
	
	if data["target_item_id"] == data["origin_item_id"] and data["origin_stackable"] == true:
		var new_stack = data["target_stack"] + data["origin_stack"]
		PlayerAttributes.item_data[target_inv_slot]["Stack"] = new_stack
		get_node("../Stack").set_text(str(new_stack))
	else:
		PlayerAttributes.item_data[target_inv_slot]["Item"] = data["origin_item_id"]
		texture = data["origin_texture"]
		PlayerAttributes.item_data[target_inv_slot]["Stack"] = data["origin_stack"]
		if data["origin_stack"] != null and data["origin_stack"] > 1:
			get_node("../Stack").set_text(str(data["origin_stack"]))
		else:
			get_node("../Stack").set_text("")


func _on_Icon_mouse_entered():
	var tool_tip_instance = tool_tip.instance()
	tool_tip_instance.origin = "Inventory"
	tool_tip_instance.slot = get_parent().get_name()
	
	tool_tip_instance.rect_position = get_parent().get_global_transform_with_canvas().origin - Vector2(300,0)
	
	add_child(tool_tip_instance)
	yield(get_tree().create_timer(0.35), "timeout")
	if has_node("ToolTip") and get_node("ToolTip").valid:
		get_node("ToolTip").show()


func _on_Icon_mouse_exited():
	get_node("ToolTip").free()
