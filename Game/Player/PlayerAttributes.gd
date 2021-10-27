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


#Information passed to and from FileManager.gd ------------

# Gets data from FileManager and saves them to the player attributes
# This includes the inventory and equipment data. save_data is the dictionary
# that contains both the inventory and equipment.
# Possibly include quests, but not sure if this needs to be contained in the game
# or the player.
func setData(load_inv, load_equip, load_save):
	inv_data = load_inv
	equipment_data = load_equip
	save_data = load_save

# Again save_data is the dictionary containing the inventory and equipment. This
# function will take the inventory and equipment and update save_data, then update
# the save_data in the FileManager so that it can then write that to a JSON file.
func setSave(filePath):
	save_data["Equpment"] = equipment_data
	save_data["Inventory"] = inv_data
	FileManager.save_data = save_data
	FileManager.saveFile(filePath)
#----------------------------------------------------------


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
	

