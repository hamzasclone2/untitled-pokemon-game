extends CanvasLayer

onready var charSheet = get_node("Control/CharacterSheet")
onready var inventory = get_node("Control/Inventory")
onready var control = get_node("Control")
onready var pauseMenu = get_node("Pause")

onready var dialogPlayer = load("res://Game/UI/DialogPlayer.tscn")
var dia = null

func _process(delta):
	if(control.visible == true):
		GameData.inventoryVisible = true
	else: 
		GameData.inventoryVisible = false
	
	if Input.is_action_just_released("inventoryMenu"):
		control.visible = !control.visible
		
	if Input.is_action_just_released("ui_cancel"):
		pauseMenu.visible = !pauseMenu.visible
		
	if(control.visible or pauseMenu.visible):
		get_tree().paused = true
	else: 
		get_tree().paused = false
		
	if(dia):
		if(dia.is_playing()):
			get_tree().paused = true
	else:
		get_tree().paused = false

func playDialog(dialogName):
	dia = dialogPlayer.instance()
	add_child(dia)
	dia.anchor_left = 0.5
	dia.anchor_right = 0.5
	dia.anchor_top = 0.5
	dia.anchor_bottom = 0.5
	dia.start(dialogName)
