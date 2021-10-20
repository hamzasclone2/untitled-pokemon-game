extends StaticBody2D

onready var UI = get_tree().root.get_node("Test/UserInterface")


func talk():
	UI.playDialog("Test")


