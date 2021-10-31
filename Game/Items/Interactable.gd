extends StaticBody2D

export(float) var item
export(float) var amount

onready var talkLabel = get_tree().root.get_node("Test/UserInterface/TalkLabel")

var isAbletoOpen : bool = true


func _ready():
	set_process(false)


func _process(delta):
	if isAbletoOpen && Input.is_action_just_pressed("ui_accept"):
		isAbletoOpen = false
		open()

func open():
	PlayerAttributes.addInventoryItem(item, amount)
	queue_free()


func _on_DetectionZone_body_entered(body):
	set_process(true)
	talkLabel.text = "Press Space to Open"
	talkLabel.visible = true


func _on_DetectionZone_body_exited(body):
	set_process(false)
	talkLabel.visible = false
