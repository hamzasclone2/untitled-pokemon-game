# Utility to represent a list of unavailable, available, active, or finished quests

extends Node

func find(_quest: Quest) -> Quest:
	for quest in get_children():
		if quest.name == _quest.name:
			return quest
	return null

func get_quests() -> Array:
	return get_children()
