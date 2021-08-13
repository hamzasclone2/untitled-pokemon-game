extends Path2D

onready var follow = get_node("follow")

func _ready():
	set_process(true)
	follow.set_unit_offset(randf())
	
func _process(delta):
	follow.set_offset(follow.get_offset() + NpcManager.get_speed("BasicEnemy") * delta)
