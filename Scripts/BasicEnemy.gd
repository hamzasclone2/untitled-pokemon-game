extends KinematicBody2D

var health = 2
onready var sprite = $Sprite
onready var AnimPlayer = $AnimationPlayer

func take_damage(damage):
	health -= damage
	AnimPlayer.play("hit")
	
func _process(delta):
	if health <= 0:
		queue_free()
