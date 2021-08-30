extends CanvasLayer

onready var charSheet = get_node("Control/CharacterSheet")
onready var inventory = get_node("Control/Inventory")
onready var control = get_node("Control")



func _process(delta):
	if Input.is_action_just_released("inventoryMenu"):
		control.visible = !control.visible
