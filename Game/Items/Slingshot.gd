extends Area2D

var bob

signal collected

func _ready():
	bob = get_tree().root.get_node("Test/Bob")


func _on_Slingshot_body_entered(body):
	if body.name == "Player":
		emit_signal("collected")
		get_tree().queue_delete(self)
