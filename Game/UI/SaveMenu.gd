extends Control

func _ready():
		
	var dir = Directory.new()
	if dir.open("user://saves/") == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		var index = 1
		while file_name != "":
			$ItemList.add_item(file_name)
			index+=1
			file_name = dir.get_next()
		dir.list_dir_end()




func _on_SaveButton_button_up():
	if($ItemList.is_anything_selected()):
		var idx = $ItemList.get_selected_items()[0]
		if(idx == 0):
			var num = $ItemList.get_item_count()
			var filePath = "user://saves/save_file" + str(num) + ".json"
			FileManager.saveFile(filePath)
		else:
			var fileName = $ItemList.get_item_text(idx)
			var filePath = "user://saves/" + fileName
			FileManager.saveFile(filePath)
	self.visible = false


func _on_CancelButton_button_up():
	self.visible = false
