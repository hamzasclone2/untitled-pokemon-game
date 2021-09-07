extends CanvasLayer

onready var charSheet = get_node("Control/CharacterSheet")
onready var inventory = get_node("Control/Inventory")
onready var control = get_node("Control")
onready var pauseMenu = get_node("Pause")


func _process(delta):
	if Input.is_action_just_released("inventoryMenu"):
		control.visible = !control.visible
		
	if Input.is_action_just_released("ui_cancel"):
		pauseMenu.visible = !pauseMenu.visible
		
	if(control.visible or pauseMenu.visible):
		get_tree().paused = true
	else:
		get_tree().paused = false

