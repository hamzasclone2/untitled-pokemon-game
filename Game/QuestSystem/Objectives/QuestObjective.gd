# Base interface for quest objective nodes. Extend it 
# to create specific objectives

extends Node
class_name QuestObjective


export var amount      : int      #Number needed to complete objective
export var type        : String   #IDEAS: Kill, collect, turn in, etc.
export var target      : String   #Asset target (enemy {BasicEnemy}, collectible {Slingshot})
export var object_text : String   #User friendly description of the objective



signal completed(objective)
signal updated(objective)

var completed: bool = false

func initialize(_amount: int, _type: String, _target: String, _object_text: String):
	amount = _amount
	type = _type
	target = _target
	object_text = _object_text


# Use this to connect signals later (enemy death, collection of maps, quest items owned)
# func connect_signals() -> void:
# 	for enemy in get_tree().get_nodes_in_group("enemies"):
# 		enemy.connect("died", self, "_on_enemy_died")





func finish() -> void:
	completed = true
	emit_signal("completed", self)

func as_text() -> String:
	return object_text
