extends Node


var health = 10
var armor = 10
var swordDamage = 1
var spearDamage = 1
var speed = 400
var threat_level = 0.2

var current_weapon = "empty"

var item_data = {}

var equipment_data = {
	"Head": null,
	"Hand": null,
	"Chest": null,
	"Legs": null,
	"Feet": null,
	"MainHand": null,
	"OffHand": null,
	"Accessory1": null,
	"Accessory2": null,
	"Accessory3": null,
	"Accessory4": null,
	"Accessory5": null,
	
}

func addInventoryItem(itemKey, amount):
	var Inventory = get_tree().root.get_node("Test/UserInterface/Control/Inventory")
	Inventory.add(itemKey, amount)

func _ready():
	var item_data_file = File.new()
	item_data_file.open("res://json_files/inv_data_file.json", File.READ)
	var item_data_json = JSON.parse(item_data_file.get_as_text())
	item_data_file.close()
	item_data = item_data_json.result
