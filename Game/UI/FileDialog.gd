extends Control

func showMenu():
	$LoadMenu.popup()

func _on_LoadMenu_file_selected(path):
	FileManager.loadFile(path)
	get_tree().change_scene("res://Game/Levels/Test.tscn")


func _on_SaveMenu_file_selected(path):
	if($SaveMenu.get_current_file() != ""):
		if not (".json" in path):
			path = path + ".json"
		PlayerAttributes.setSave(path)
