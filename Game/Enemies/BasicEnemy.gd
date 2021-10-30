extends KinematicBody2D

onready var health = NpcManager.get_health("BasicEnemy")
onready var sprite = $Sprite
onready var AnimPlayer = $AnimationPlayer
var attack = 5
var enemyType = "BasicEnemy"

onready var healthBar = $HealthBar

var speed = NpcManager.get_speed("BasicEnemy")
var velocity = Vector2.ZERO

var player = null

func take_damage(damage):
	health -= damage
	healthBar._on_health_updated(health)
	AnimPlayer.stop(true)
	AnimPlayer.play("hit")
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * speed
	velocity = move_and_slide(velocity)
	if health <= 0:
		queue_free()


func _ready():
	healthBar._on_health_updated(health)


func _on_DetectionZone_body_entered(body):
	player = body


func _on_DetectionZone_body_exited(body):
	player = null
