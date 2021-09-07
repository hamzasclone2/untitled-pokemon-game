extends Node

var experience = 0
var health = 10
var maxHealth = 10
var armor = 10
var maxArmor = 10
var swordDamage = 1
var spearDamage = 1
var speed = 400
var threat_level = 0.2

var current_weapon = "empty"

var inv_data = {}

var equipment_data = {
	"Head": null,
	"Hand": null,
	"Chest": null,
	"Legs": null,
	"Feet": null,
	"MainHand": null,
	"OffHand": null,
	"Accessory": null,
	
}

func addInventoryItem(itemKey, amount):
	var Inventory = get_tree().root.get_node("Test/UserInterface/Control/Inventory")
	Inventory.add(itemKey, amount)

func _ready():
	var inv_data_file = File.new()
	inv_data_file.open("res://json_files/inv_data_file.json", File.READ)
	var inv_data_json = JSON.parse(inv_data_file.get_as_text())
	inv_data_file.close()
	inv_data = inv_data_json.result
