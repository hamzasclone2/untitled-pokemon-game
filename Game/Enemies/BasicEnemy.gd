extends KinematicBody2D

onready var health = NpcManager.get_health("BasicEnemy")
onready var sprite = $Sprite
onready var AnimPlayer = $AnimationPlayer
var attack = 5
var enemyType = "BasicEnemy"

onready var healthBar = $HealthBar

var speed = NpcManager.get_speed("BasicEnemy")
var velocity = Vector2.ZERO

var hitstun = 0
var knockDir = Vector2.ZERO

var player = null

func take_damage(damage, body):
	if hitstun == 0:
		hitstun = 10
		knockDir = transform.origin - body.transform.origin
	
	health -= damage
	healthBar._on_health_updated(health)
	AnimPlayer.stop(true)
	AnimPlayer.play("hit")
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	if player and hitstun == 0:
		velocity = position.direction_to(player.position) * speed
	elif hitstun > 0:
		velocity = knockDir.normalized() * speed * 2.5
	else:
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)
	
	if hitstun > 0:
		hitstun -= 1
	
	if health <= 0:
		queue_free()


func _ready():
	healthBar._on_health_updated(health)


func _on_DetectionZone_body_entered(body):
	player = body


func _on_DetectionZone_body_exited(body):
	player = null
