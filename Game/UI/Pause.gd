extends Control


func _on_ResumeButton_button_up():
	self.visible = false


func _on_QuitButton_button_up():
	get_tree().quit()


func _on_SaveButton_button_up():
	self.visible = false
	get_parent().get_node("SaveMenu").visible = true
	
