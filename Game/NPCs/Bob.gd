extends "res://Game/NPCs/Instanceable/NPC.gd"


onready var quests = QuestSystem.bob_quests

var _quest

func _ready():

	for u_quest in QuestSystem.unavailable_quests.get_quests():
		if u_quest.name == quests[0]:
			_quest = u_quest

	QuestSystem.unavailable_quests.remove_child(_quest)
	QuestSystem.available_quests.add_child(_quest)


func talk():
	UI.playDialog("BranchTest")
	QuestSystem.start(_quest)
	
