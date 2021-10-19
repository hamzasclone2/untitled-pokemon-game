extends Node

onready var BodyAnimPlayer = find_node("BodyAnimPlayer")
onready var BodyLabel = find_node("BodyLabel")
onready var DialogBox = find_node("DialogBox")
onready var OptionList = find_node("OptionList")
onready var SelectChoiceIcon = find_node("SelectChoice")
onready var SpeakerLabel = find_node("SpeakerLabel")
onready var SpaceBarIcon = find_node("SpaceBar")

onready var OptionButtonScene = load("res://Game/UI/Option.tscn")

var did = 0
var nid = 0
var final_nid = 0
var StoryReader

func _ready():
	var StoryReaderClass = load("res://addons/EXP-System-Dialog/Reference_StoryReader/EXP_StoryReader.gd")
	StoryReader = StoryReaderClass.new()
	var story = load("res://Stories/test_baked.tres")
	StoryReader.read(story)
	
	DialogBox.visible = false
	SpaceBarIcon.visible = false
	SelectChoiceIcon.visible = false
	OptionList.visible = false
	
	clear_options()
	
	play_dialog("BranchTest")
	
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_SPACE and event.pressed == true:
			on_DialogPlayer_pressed_spacebar()

func _on_BodyAnimPlayer_animation_finished(anim_name):
	if OptionList.get_child_count() == 0:
		SpaceBarIcon.visible = true
	else:
		SelectChoiceIcon.visible = true
		OptionList.visible = true

func on_DialogPlayer_pressed_spacebar():
	if is_waiting():
		SpaceBarIcon.visible = false
		get_next_node()
		if is_playing():
			play_node()
	

func on_Option_clicked(slot):
	SelectChoiceIcon.visible = false
	OptionList.visible = false
	get_next_node(slot)
	clear_options()
	if is_playing():
		play_node()

func play_dialog(record_name : String):
	did = StoryReader.get_did_via_record_name(record_name)
	nid = StoryReader.get_nid_via_exact_text(did, "<start>")
	final_nid = StoryReader.get_nid_via_exact_text(did, "<end>")
	get_next_node()
	play_node()
	DialogBox.visible = true
	
func is_playing() -> bool:
	return DialogBox.visible
	
func is_waiting() -> bool:
	return SpaceBarIcon.visible
	
func clear_options():
	var children = OptionList.get_children()
	for child in children:
		OptionList.remove_child(child)
		child.queue_free()

func get_next_node(slot : int = 0):
	nid = StoryReader.get_nid_from_slot(did, nid, slot)
	if nid == final_nid:
		DialogBox.visible = false
	
func get_tagged_text(tag: String, text: String) -> String:
	var start_tag = "<" + tag + ">"
	var end_tag = "</" + tag + ">"
	var start_index = text.find(start_tag) + start_tag.length()
	var end_index = text.find(end_tag)
	var substrLength = end_index - start_index
	return text.substr(start_index, substrLength)

func play_node():
	var text = StoryReader.get_text(did, nid)
	var speaker = get_tagged_text("speaker", text)
	var dialog = get_tagged_text("dialog", text)
	if "<choiceJSON>" in text:
		var options = get_tagged_text("choiceJSON", text)
		populate_choices(options)
	
	SpeakerLabel.text = speaker
	BodyLabel.text = dialog
	BodyAnimPlayer.play("TextDisplay")

func populate_choices(JSONtext: String):
	var choices : Dictionary = parse_json(JSONtext)
	
	for text in choices:
		var slot = choices[text]
		var new_option_button = OptionButtonScene.instance()
		OptionList.add_child(new_option_button)
		new_option_button.slot = slot
		new_option_button.set_text(text)
		new_option_button.connect("clicked", self, "on_Option_clicked")
