extends Node

var health = 10
var armor = 10
var swordDamage = 1
var spearDamage = 1
var speed = 400
var threat_level = 0.2

var current_weapon = "empty"

var item_data = {}

func _ready():
	var item_data_file = File.new()
	item_data_file.open("res://json_files/inv_data_file.json", File.READ)
	var item_data_json = JSON.parse(item_data_file.get_as_text())
	item_data_file.close()
	item_data = item_data_json.result
