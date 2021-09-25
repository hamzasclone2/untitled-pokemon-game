extends Node

var experience = 0
var health = 100
var maxHealth = 100
var armor = 0
var damage = 0
var speed = 400

var current_weapon_type = null
var current_weapon = null

var current_off_weapon_type = null
var current_off_weapon = null
var off_damage = 0

var numArrows = 10

var inv_data = {}

var equipment_data = {}

var save_data = {}

func addInventoryItem(itemKey, amount):
	var Inventory = get_tree().root.get_node("Test/UserInterface/Control/Inventory")
	Inventory.add(itemKey, amount)

func loadFile(filePath):
	var save_file = File.new()
	save_file.open(filePath, File.READ)
	var save_file_json = JSON.parse(save_file.get_as_text())
	save_file.close()
	save_data = save_file_json.result
	inv_data = save_data["Inventory"]
	equipment_data = save_data["Equipment"]
	
func save_game():
	save_data["Equipment"] = equipment_data
	save_data["Inventory"] = inv_data
	var file
	file = File.new()
	file.open("user://save_file.json", File.WRITE)
	file.store_line(to_json(save_data))
	file.close()
	
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
		
	if equipment_data["OffHand"] != null:
		current_off_weapon = GameData.item_data[str(equipment_data["OffHand"])]
		off_damage = current_off_weapon["Attack"]
		current_off_weapon_type = current_off_weapon["Type"]
		if current_weapon_type == "Bow":
			get_tree().root.get_node("Test/Player/Bow/Sprite").texture = load("res://Images/Icon_Items/" + current_weapon["Name"] + ".png")
	else:
		off_damage = 0
		current_off_weapon_type = null
		
	armor = 0
	if equipment_data["Head"] != null:
		armor = GameData.item_data[str(equipment_data["Head"])]["Defense"] + armor
	if equipment_data["Hand"] != null:
		armor = GameData.item_data[str(equipment_data["Hand"])]["Defense"] + armor
	if equipment_data["Chest"] != null:
		armor = GameData.item_data[str(equipment_data["Chest"])]["Defense"] + armor
	if equipment_data["Legs"] != null:
		armor = GameData.item_data[str(equipment_data["Legs"])]["Defense"] + armor
	if equipment_data["Feet"] != null:
		armor = GameData.item_data[str(equipment_data["Feet"])]["Defense"] + armor
	

func newGame():
	save_data = {
  "Equipment": {
	"Accessory": null,
	"Chest": null,
	"Feet": null,
	"Hand": null,
	"Head": null,
	"Legs": null,
	"MainHand": null,
	"OffHand": null
  },
  "Inventory": {
	"Inv01": {
	  "Item": null,
	  "Stack": null
	},
	"Inv02": {
	  "Item": null,
	  "Stack": null
	},
	"Inv03": {
	  "Item": null,
	  "Stack": null
	},
	"Inv04": {
	  "Item": null,
	  "Stack": null
	},
	"Inv05": {
	  "Item": null,
	  "Stack": null
	},
	"Inv06": {
	  "Item": null,
	  "Stack": null
	},
	"Inv07": {
	  "Item": null,
	  "Stack": null
	},
	"Inv08": {
	  "Item": null,
	  "Stack": null
	},
	"Inv09": {
	  "Item": null,
	  "Stack": null
	},
	"Inv10": {
	  "Item": null,
	  "Stack": null
	},
	"Inv11": {
	  "Item": null,
	  "Stack": null
	},
	"Inv12": {
	  "Item": null,
	  "Stack": null
	},
	"Inv13": {
	  "Item": null,
	  "Stack": null
	},
	"Inv14": {
	  "Item": null,
	  "Stack": null
	},
	"Inv15": {
	  "Item": null,
	  "Stack": null
	},
	"Inv16": {
	  "Item": null,
	  "Stack": null
	},
	"Inv17": {
	  "Item": null,
	  "Stack": null
	},
	"Inv18": {
	  "Item": null,
	  "Stack": null
	},
	"Inv19": {
	  "Item": null,
	  "Stack": null
	},
	"Inv20": {
	  "Item": null,
	  "Stack": null
	},
	"Inv21": {
	  "Item": null,
	  "Stack": null
	},
	"Inv22": {
	  "Item": null,
	  "Stack": null
	},
	"Inv23": {
	  "Item": null,
	  "Stack": null
	},
	"Inv24": {
	  "Item": null,
	  "Stack": null
	},
	"Inv25": {
	  "Item": null,
	  "Stack": null
	}
  }
}
	inv_data = save_data["Inventory"]
	equipment_data = save_data["Equipment"]
