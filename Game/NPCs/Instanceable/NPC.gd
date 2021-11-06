extends StaticBody2D

onready var talkLabel = get_tree().root.get_node("Test/UserInterface/TalkLabel")
onready var UI = get_tree().root.get_node("Test/UserInterface")

var isAbletoTalk: bool = true

func _ready():
	set_process(false)


func _process(delta):
	if isAbletoTalk && Input.is_action_just_pressed("ui_accept"):
		isAbletoTalk = false
		talkLabel.visible = false
		talk()
		


func talk():
	pass


func _on_DetectionZone_body_entered(body):
	set_process(true)
	talkLabel.text = "Press Space to Talk"
	talkLabel.visible = true
	isAbletoTalk = true


func _on_DetectionZone_body_exited(body):
	set_process(false)
	talkLabel.visible = false
