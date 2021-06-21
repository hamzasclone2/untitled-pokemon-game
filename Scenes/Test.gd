extends Node2D

var player


func _ready():
	player = load("Scenes/Player.tscn").instance()
	add_child(player)
	player.position = Vector2(500, 500)

