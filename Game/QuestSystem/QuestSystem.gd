# Provides a simple API to start and to deliver quests, using the start() and
# deliver() methods respectively.
# Uses 5 QuestContainer nodes to store all unavailable, available, active,
# completed, and delivered (finished) quests.

extends Node

# QuestContainers
onready var unavailable_quests = $Unavailable
onready var available_quests = $Available
onready var active_quests = $Active
onready var completed_quests = $Completed      # Bucket for Quests where all objectives have been completed
onready var delivered_quests = $Delivered      # Bucket for Quests where the quest has been turned in


# Variables for each NPC
var bob_quests = []



# When a new game is started initialize() is called
# It opens a json file and then reads the data inside of it
# The data is then stored in quest_data
# With quest_data we will use that data to generate Quests using the initialize
# function of the Quest class
func initialize():
	
	# Storing the json data in dictionary quest_data
	var quest_data = {}
	var quest_data_file = File.new()
	quest_data_file.open("res://json_files/Quests.json", File.READ)
	var quest_data_json = JSON.parse(quest_data_file.get_as_text())
	quest_data_file.close()
	quest_data = quest_data_json.result
	
	
	# Iterate through the dictionary quest_data
	# The keys aren't important at the highest level, they just act as an index
	# For each key, call the Quest initialize function passsing in the quest's
	# title, quest flavor text, and who the player will get the quest from
	# Add the quest to the Unavailable container. Will figure out how to assign
	# the quests to an NPC or bounty board later.
	# After the Quest instance has been created, call add_objectives and pass in
	# the array of objectives. This will allow the creation of objective instances
	# in this quest instance after the objective and reward buckets have been created
	for key in quest_data:
		var _quest = preload("res://Game/QuestSystem/Quest.tscn").instance()
		_quest.initialize(quest_data[key]["Title"], quest_data[key]["QuestText"], quest_data[key]["Owner"])
		unavailable_quests.add_child(_quest)
	
		_quest.add_objectives(quest_data[key]["Objectives"])
		
		if quest_data[key]["Owner"] == "Bob":
			bob_quests.append(quest_data[key]["Title"])



# Pass in a quest, call QuestContainer's find function with the quest. Specifically
# looking at the available bucket. If it is available return the quest, otherwise
# return null.
func find_available(reference: Quest) -> Quest:
	return available_quests.find(reference)


# Calls the QuestContainer's get_quests function. Returns all quests that are in
# the avialable bucket.
func get_available_quests() -> Array:
	return available_quests.get_quests()


# Pass in a Quest, call QuestContainer's find function with the Quest. Specifically
# looking at the available bucket. If it returns a quest, return true, if it returns
# null return false.
func is_available(reference: Quest) -> bool:
	return available_quests.find(reference) != null


# Pass in a Quest, call QuestContainer's find function with the Quest. Specifically
# looking at the available bucket. Connect the Quest's completed signal to the 
# _on_Quest_completed function for the quest returned by the find function.
# Then remove it from the available bucke tand add it to the active bucket.
# Call Quest's _start function.
func start(reference: Quest):
	var quest: Quest = available_quests.find(reference)
	quest.connect("completed", self, "_on_Quest_completed", [quest])
	available_quests.remove_child(quest)
	active_quests.add_child(quest)
	quest._start()


# Function is called when a Quest uses it's completed signal.
# Remove the quest from the active bucket and move it to the completed bucket
func _on_Quest_completed(quest):
	active_quests.remove_child(quest)
	completed_quests.add_child(quest)


# Function for turning in quests.      INCOMPLETE
# Call Quest's _deliver function
# Add code for how we interact with rewards
# Move the Quest from the completed bucket to the delivered bucket
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
