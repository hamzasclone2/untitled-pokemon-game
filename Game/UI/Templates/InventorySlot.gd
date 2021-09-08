extends TextureRect

onready var tool_tip = preload("res://Game/UI/Templates/ToolTip.tscn")
onready var split_popup = preload("res://Game/UI/Templates/ItemSplitPopup.tscn")

func get_drag_data(_pos):
	if get_tree().get_nodes_in_group("Splitter"):
		return
	var inv_slot = get_parent().get_name()
	if PlayerAttributes.inv_data[inv_slot]["Item"] != null:
		var data = {}
		data["origin_node"] = self
		data["origin_panel"] = "Inventory"
		data["origin_item_id"] = PlayerAttributes.inv_data[inv_slot]["Item"]
		data["origin_equipment_slot"] = GameData.item_data[str(PlayerAttributes.inv_data[inv_slot]["Item"])]["EquipmentSlot"]
		data["origin_stackable"] = GameData.item_data[str(PlayerAttributes.inv_data[inv_slot]["Item"])]["Stackable"]
		data["origin_stack"] = PlayerAttributes.inv_data[inv_slot]["Stack"]
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
	if PlayerAttributes.inv_data[target_inv_slot]["Item"] == null:
		data["target_item_id"] = null
		data["target_texture"] = null
		data["target_stack"] = null
		return true
	else:
		if Input.is_action_pressed("secondary"):
			return false
		else:
			data["target_item_id"] = PlayerAttributes.inv_data[target_inv_slot]["Item"]
			data["target_texture"] = texture
			data["target_stack"] = PlayerAttributes.inv_data[target_inv_slot]["Stack"]
			if data["origin_panel"] == "CharacterSheet":
				var target_equipment_slot = GameData.item_data[str(PlayerAttributes.inv_data[target_inv_slot]["Item"])]["EquipmentSlot"]
				if target_equipment_slot == data["origin_equipment_slot"]:
					return true
				else:
					return false
			else:
				return true
	


	
func drop_data(_pos, data):
	var target_inv_slot = get_parent().get_name()
	var origin_slot = data["origin_node"].get_parent().get_name()
	if data["origin_node"] == self:
		pass
		
	elif Input.is_action_pressed("secondary") and data["origin_panel"] == "Inventory" and data["origin_stack"] > 1:
		var split_popup_instance = split_popup.instance()
		split_popup_instance.rect_position = get_parent().get_global_transform_with_canvas().origin + Vector2(0, 100)
		split_popup_instance.data = data
		add_child(split_popup_instance)
		get_node("ItemSplitPopup").show()
	else:
	
		if data["target_item_id"] == data["origin_item_id"] and data["origin_stackable"] == true:
			PlayerAttributes.inv_data[origin_slot]["Item"] = null
			PlayerAttributes.inv_data[origin_slot]["Stack"] = null
		elif data["origin_panel"] == "Inventory":
			PlayerAttributes.inv_data[origin_slot]["Item"] = data["target_item_id"]
			PlayerAttributes.inv_data[origin_slot]["Stack"] = data["target_stack"]
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
			PlayerAttributes.inv_data[target_inv_slot]["Stack"] = new_stack
			get_node("../Stack").set_text(str(new_stack))
		else:
			PlayerAttributes.inv_data[target_inv_slot]["Item"] = data["origin_item_id"]
			texture = data["origin_texture"]
			PlayerAttributes.inv_data[target_inv_slot]["Stack"] = data["origin_stack"]
			if data["origin_stack"] != null and data["origin_stack"] > 1:
				get_node("../Stack").set_text(str(data["origin_stack"]))
			else:
				get_node("../Stack").set_text("")
				
		PlayerAttributes.checkEquipment()

func SplitStack(split_amount, data):
	var target_inv_slot = get_parent().get_name()
	var origin_slot = data["origin_node"].get_parent().get_name()
	
	PlayerAttributes.inv_data[origin_slot]["Stack"] = data["origin_stack"] - split_amount
	PlayerAttributes.inv_data[target_inv_slot]["Item"] = data["origin_item_id"]
	PlayerAttributes.inv_data[target_inv_slot]["Stack"] = split_amount
	texture = data["origin_texture"]
	
	if data["origin_stack"] - split_amount > 1:
		data["origin_node"].get_node("../Stack").set_text(str(data["origin_stack"] - split_amount))
	else:
		data["origin_node"].get_node("../Stack").set_text("")
		
	if split_amount > 1:
		get_node("../Stack").set_text(str(split_amount))
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
