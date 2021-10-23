# Represents a quest the player can take on.
# Uses child Objective nodes to track tasks the player has to complete
# And Questitem

extends Node
class_name Quest

signal started
signal completed
signal delivered

onready var objectives = $Objectives

export var title: String
export var description: String

export var reward_ondelivery: bool = false
export var _reward_experience: int
onready var _reward_items: Node = $ItemRewards


func initialize(_title: String, _description: String):
	#Set title and description
	title = _title
	description = _description
	self.name = _title

func add_objectives(_objectives: Array):
	for i in range(0, _objectives.size()):
		var _object = QuestObjective.new()
		_object.initialize(_objectives[i][0], _objectives[i][1], _objectives[i][2], _objectives[i][3])
		_object.name = "Objective " + str(i + 1)
		objectives.add_child(_object)
		#get_child(1).add_child(_object)
	#Create new objectives from the objective array
	#The length of the array should be how many objectives there are


func _start():
	for objective in get_objectives():
		objective.connect("completed", self, "_on_Objective_completed")
	emit_signal("started")

func get_objectives():
	return objectives.get_children()

func get_completed_objectives():
	var completed: Array = []
	for objective in get_objectives():
		if not objective.completed:
			continue
		completed.append(objective)
	return completed

func _on_Objective_Completed(objective) -> void:
	if get_completed_objectives().size() == get_objectives().size():
		emit_signal("completed")

func _deliver():
	emit_signal("delivered")

func get_rewards_as_text() -> Array:
	var text := []
	text.append(" - Experience: %s" %str(_reward_experience))
	for item in _reward_items.get_children():
		text.append(" - [%s] X (%s)\n" % [item.item.name, str(item.amount)])
	return text
