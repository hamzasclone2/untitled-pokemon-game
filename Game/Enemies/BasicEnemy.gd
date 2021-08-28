extends KinematicBody2D

onready var health = NpcManager.get_health("BasicEnemy")
onready var sprite = $Sprite
onready var AnimPlayer = $AnimationPlayer
onready var ThreatArea = $Area2D/ThreatArea
export var agro = 0
var attack = 1

var speed = NpcManager.get_speed("BasicEnemy")
var velocity = Vector2()

func take_damage(damage):
	health -= damage
	AnimPlayer.stop(true)
	AnimPlayer.play("hit")
	
func _process(delta):
	if health <= 0:
		queue_free()


func _ready():
	ThreatArea.scale.x = agro * PlayerAttributes.threat_level
	ThreatArea.scale.y = agro * PlayerAttributes.threat_level


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print ("HES GONNA GET IT!")
		
