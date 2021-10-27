# Utility to represent a list of unavailable, available, active, or finished quests

extends Node


# Pass in a Quest. Loop through all the quests in the QuestContainer, and checks the
# name of the quests. If the quest is equal to the quest we passed in then return
# the quest. If all quests have been checked with no match, return null
func find(_quest: Quest) -> Quest:
	for quest in get_children():
		if quest.name == _quest.name:
			return quest
	return null

# Returns the children of the QuestContainer
func get_quests() -> Array:
	return get_children()
