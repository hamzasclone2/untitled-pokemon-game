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

func addInventoryItem(itemKey, amount):
	var Inventory = get_tree().root.get_node("Test/UserInterface/Control/Inventory")
	Inventory.add(itemKey, amount)

func _ready():
	var inv_data_file = File.new()
	inv_data_file.open("user://inv_data_file.json", File.READ)
	var inv_data_json = JSON.parse(inv_data_file.get_as_text())
	inv_data_file.close()
	inv_data = inv_data_json.result
	
	var equip_data_file = File.new()
	equip_data_file.open("user://equip_data_file.json", File.READ)
	var equip_data_json = JSON.parse(equip_data_file.get_as_text())
	equip_data_file.close()
	equipment_data = equip_data_json.result
	
func save_game():
	var file
	file = File.new()
	file.open("user://inv_data_file.json", File.WRITE)
	file.store_line(to_json(inv_data))
	file.close()
	
	file = File.new()
	file.open("user://equip_data_file.json", File.WRITE)
	file.store_line(to_json(equipment_data))
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
	
