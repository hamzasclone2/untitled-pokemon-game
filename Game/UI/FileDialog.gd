extends Control

func showMenu(type):
	if type == "Load":
		$LoadMenu.popup()
	elif type == "Save":
		$SaveMenu.popup()

func _on_LoadMenu_file_selected(path):
	PlayerAttributes.loadFile(path)
	get_tree().change_scene("res://Game/Levels/Test.tscn")
