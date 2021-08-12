extends Node2D

var ARROW_SCENE = preload("res://Scenes/Arrow.tscn")

onready var arrow_pos = $ArrowPos

var dir = Vector2()

func shoot():
	var arrow = ARROW_SCENE.instance()
	get_parent().get_parent().add_child(arrow)
	arrow.set_position(get_node("ArrowPos").get_global_position())
	arrow.set_rotation(get_parent().get_global_rotation() + (45 * PI/180))
	var dir1: float = get_global_mouse_position().x - arrow.get_global_position().x
	var dir2: float = get_global_mouse_position().y - arrow.get_global_position().y
	var dirmax: float = max(abs(dir1), abs(dir2))
	
	dir1 = dir1 / dirmax
	dir2 = dir2 / dirmax
	dir = Vector2(dir1, dir2)
	#print (dir)
	arrow.set_dir(dir)
