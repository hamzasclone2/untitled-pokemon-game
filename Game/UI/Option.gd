extends NinePatchRect

signal clicked(slot)

onready var Button = $Button

var slot

func set_text(new_text: String):
	Button.text = new_text
	


func _on_Button_pressed():
	emit_signal("clicked", slot)
