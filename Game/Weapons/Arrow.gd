extends Node2D

var loc_dir = Vector2()

var arrow_range = 250
#Do we want this range to be based on the motion or raw data from loc_dir.
#It's currently set up the second way. 

var dir_hyp = 0

var on_floor = false

func set_dir(dir: Vector2):
	loc_dir = dir

func _physics_process(_delta):
	var speed_x = loc_dir.x
	var speed_y = loc_dir.y
	var motion = Vector2(speed_x, speed_y) * 25
	set_position(get_position() + motion)
	dir_hyp = dir_hyp + sqrt((speed_x * speed_x) + (speed_y * speed_y))
	if dir_hyp > arrow_range:
		on_floor = true
		set_physics_process(false)
	


func _on_Pickup_body_entered(body):
	if on_floor == true && body.name == "Player":
		PlayerAttributes.numArrows += 1
		queue_free()


func _on_ArrowTip_body_entered(body):
	if body.name != "Player" and body.is_in_group("enemy"):
		body.take_damage(PlayerAttributes.off_damage, self)
		queue_free()
	elif body.name != "Player":
		set_physics_process(false)
		on_floor = true
