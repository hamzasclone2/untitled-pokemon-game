extends Node2D

var ARROW_SCENE = preload("res://Scenes/Arrow.tscn")

onready var arrow_pos = $ArrowPos

var dir = Vector2()

func shoot():
	var arrow = ARROW_SCENE.instance()
	get_parent().get_parent().add_child(arrow)
	arrow.set_rotation(arrow_pos.get_rotation())
	arrow.set_position(arrow_pos.get_global_position())
	dir = Vector2(get_global_mouse_position().x - arrow.get_global_position().x, get_global_mouse_position().y - arrow.get_global_position().y)
	arrow.set_dir(dir)
