extends KinematicBody2D

var health = 2
onready var sprite = $Sprite

func take_damage(damage):
	health -= damage
	sprite.modulate = Color(0,1,0)
	
func _process(delta):
	if health <= 0:
		queue_free()
