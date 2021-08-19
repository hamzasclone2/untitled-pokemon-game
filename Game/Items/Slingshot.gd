extends Area2D

var bob

func _ready():
	bob = get_tree().root.get_node("Test/Bob")


func _on_Slingshot_body_entered(body):
	if body.name == "Player":
		get_tree().queue_delete(self)
		bob.slingshot_found = true
