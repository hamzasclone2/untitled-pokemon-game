extends StaticBody2D

enum QuestStatus { NOT_STARTED, STARTED, COMPLETED }
var quest_status = QuestStatus.NOT_STARTED
var dialogue_state = 0

var dialoguePopup
var player
var slingshot_found

func _ready():
	dialoguePopup = get_tree().root.get_node("Test/UserInterface/DialoguePopup")
	player = get_tree().root.get_node("Test/Player")
	
func talk(answer = ""):
	dialoguePopup.npc = self
	dialoguePopup.npc_name = "Bob"
	match quest_status:
		QuestStatus.NOT_STARTED:
			match dialogue_state:
				0:
					dialogue_state = 1
					dialoguePopup.dialogue = "Hello Warrior! Do you think you could find my slingshot for me?"
					dialoguePopup.answers = "[Y]es [N]o"
					dialoguePopup.open()
				1:
					match answer:
						"Y":
							dialogue_state = 2
							dialoguePopup.dialogue = "Thank you! I'll give you a cool sword once you find it."
							dialoguePopup.answers = "[Y]up!"
							dialoguePopup.open()
						"N":
							dialogue_state = 3
							dialoguePopup.dialogue = "I'll give you a cool sword if you help me!"
							dialoguePopup.answers = "[Y]eah..."
							dialoguePopup.open()
				2:
					dialogue_state = 0
					quest_status = QuestStatus.STARTED
					dialoguePopup.close()
				3:
					dialogue_state = 0
					dialoguePopup.close()
		QuestStatus.STARTED:
			match dialogue_state:
				0:
					dialogue_state = 1
					dialoguePopup.dialogue = "Have you found it yet?"
					if slingshot_found:
						dialoguePopup.answers = "[Y]es [N]o"
					else:
						dialoguePopup.answers = "[N]o"
					dialoguePopup.open()
				1:
					if slingshot_found and answer == "Y":
						dialogue_state = 2
						dialoguePopup.dialogue = "Thanks, here's the sword!"
						dialoguePopup.answers = "[Y]eah no problem!"
						dialoguePopup.open()
						PlayerAttributes.addInventoryItem(10003, 1)
					else:
						dialogue_state = 3
						dialoguePopup.dialogue = "Oh...well you said you would..."
						dialoguePopup.answers = "[Y]eah, I'm working on it!"
						dialoguePopup.open()
				2:
					dialogue_state = 0
					quest_status = QuestStatus.COMPLETED
					dialoguePopup.close()
				3:
					dialogue_state = 0
					dialoguePopup.close()
		QuestStatus.COMPLETED:
			match dialogue_state:
				0:
					dialogue_state = 1
					dialoguePopup.dialogue = "Thanks again for your help!"
					dialoguePopup.answers = "[Y]up."
					dialoguePopup.open()
				1:
					dialogue_state = 0
					dialoguePopup.close()


func _on_TalkArea_area_entered(body):
	if(body.name == "Player"):
		print("entered!")
