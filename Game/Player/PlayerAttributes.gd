extends Node

var experience = 0
var health = 10
var maxHealth = 10
var armor = 10
var maxArmor = 10
var damage = 0
var spearDamage = 1
var speed = 400
var threat_level = 0.2

var current_weapon_type = null
var current_weapon = null

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
	
func checkEquipment():
	if equipment_data["MainHand"] != null:
		current_weapon = GameData.item_data[str(equipment_data["MainHand"])]
		damage = current_weapon["Attack"]
		current_weapon_type = current_weapon["Type"]
		if current_weapon_type == "Sword":
			get_tree().root.get_node("Test/Player/Sword/Sprite").texture = load("res://Images/Icon_Items/" + current_weapon["Name"] + ".png")
	else:
		damage = 0
		current_weapon_type = null
