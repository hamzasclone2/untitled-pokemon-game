extends Control



func _on_PlayButton_button_up():
	FileManager.newGame()
	get_tree().change_scene("res://Game/Levels/Test.tscn")


func _on_QuitButton_button_up():
	get_tree().quit()


func _on_LoadButton_button_up():
	$FileDialog.showMenu("Load")
