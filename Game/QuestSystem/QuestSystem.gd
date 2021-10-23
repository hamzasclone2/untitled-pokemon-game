# Provides a simple API to start and to deliver quests, using the start() and
# deliver() methods respectively.
# Uses 5 QuestContainer nodes to store all unavailable, available, active,
# completed, and delivered (finished) quests.

extends Node

onready var unavialable_quests = $Unavailable
onready var available_quests = $Available
onready var active_quests = $Active
onready var completed_quests = $Completed
onready var delivered_quests = $Delivered



func initialize():
	#On New Game start, take all quests from a json file and turn them into quest
	#objects and put them in the unavailable bucket
	var quest_data = {}
	var quest_data_file = File.new()
	quest_data_file.open("res://json_files/Quests.json", File.READ)
	var quest_data_json = JSON.parse(quest_data_file.get_as_text())
	quest_data_file.close()
	quest_data = quest_data_json.result
	
	
	"""
	Iterate through the dictionary for each quest. The keys are just identifiers
	that don't matter so we don't need to store them. (10001, 10002, etc.)
	"""
	for key in quest_data:
		var _quest = preload("res://Game/QuestSystem/Quest.tscn").instance()
		_quest.initialize(quest_data[key]["Title"], quest_data[key]["QuestText"])
		unavialable_quests.add_child(_quest)
	
		_quest.add_objectives(quest_data[key]["Objectives"])




func find_available(reference: Quest) -> Quest:
	# Returns the Quest corresponding to the reference instance,
	# to track it's state or connect to it.
	return available_quests.find(reference)

func get_available_quests() -> Array:
	return available_quests.get_quests()

func is_available(reference: Quest) -> bool:
	return available_quests.find(reference) != null

func start(reference: Quest):
	var quest: Quest = available_quests.find(reference)
	quest.connect("completed", self, "_on_Quest_completed", [quest])
	available_quests.remove_child(quest)
	active_quests.add_child(quest)
	quest._start()

func _on_Quest_completed(quest):
	active_quests.remove_child(quest)
	completed_quests.add_child(quest)

func deliver(quest: Quest):
	# Marks the quest as complete, rewards the player,
	# and removes it from completed quests.
	quest._deliver()
	# Player rewards
	# This needs to be something that we write, as our game functions
	# Entirely different from this game.
	
	assert(quest.get_parent() == completed_quests)
	completed_quests.remove_child(quest)
	delivered_quests.add_child(quest)
