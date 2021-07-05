extends Node2D

var loc_dir = Vector2()

func set_dir(dir: Vector2):
	loc_dir = dir

func _process(delta):
	var speed_x = loc_dir.x
	var speed_y = loc_dir.y
	var motion = Vector2(speed_x, speed_y) * 1
	set_position(get_position() + motion * delta)
