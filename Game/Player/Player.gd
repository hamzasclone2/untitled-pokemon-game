extends KinematicBody2D

# I think you might want a friction that is higher than the players speed
# and an acceleration that is slightly lower than the players speed.
const FRICTION = 750
const ACCELERATION = 600

var velocity = Vector2()
var knockback = Vector2.ZERO

onready var sword = $Sword
onready var bow = $Bow
onready var AnimPlayer = $AnimationPlayer

onready var healthBar = get_parent().get_node("UserInterface/HealthBar")

var weapons = ["empty", "sword", "spear", "bow"]
var weaponsIndex = 0

var isAbleToTalk = false
var isAbleToOpen = false

var npc
var treasureChest

onready var talkLabel = get_tree().root.get_node("Test/UserInterface/TalkLabel")


func get_input():
	PlayerAttributes.checkEquipment()
	if Input.is_action_just_pressed("click") and PlayerAttributes.equipment_data["MainHand"] != null:
		if PlayerAttributes.current_weapon_type == "Sword":
			sword.visible = true
			bow.visible = false
			sword.attack()
	elif Input.is_action_just_pressed("rightClick") and PlayerAttributes.equipment_data["OffHand"] != null:
		if PlayerAttributes.current_off_weapon_type == "Bow" and PlayerAttributes.numArrows > 0:
			bow.visible = true
			sword.visible = false
			bow.shoot()
			PlayerAttributes.numArrows -= 1



func _ready():
	PlayerAttributes.connect("player_died", self, "_on_player_died")


func _process(_delta):
	# Moved this stuff to _process because they don't do anything with the physics
	# of the game. 
	if(PlayerAttributes.equipment_data["MainHand"] == null):
		sword.visible = false
	if(PlayerAttributes.equipment_data["OffHand"] ==  null):
		bow.visible = false
	get_input()
	
	if(isAbleToTalk):
		if(Input.is_action_just_pressed("ui_accept")):
			talkLabel.visible = false
			npc.talk()
			talkLabel.visible = true

	if(isAbleToOpen):
		if(Input.is_action_just_pressed("ui_accept")):
			treasureChest.open()
			isAbleToOpen = false




func _physics_process(delta):
	
	# Player movement ----------------------------------------------------------
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		# For acceleration, commented code is just setting the velocity to our speed
		velocity = velocity.move_toward(input_vector * PlayerAttributes.speed, ACCELERATION * delta)
		#velocity = input_vector * PlayerAttributes.speed
	else:
		# For friction, commented code is just setting the velocity to 0
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		#velocity = Vector2.ZERO
	
	velocity = move_and_slide(velocity)
	# --------------------------------------------------------------------------
	
	knockback(delta)
	look_at(get_global_mouse_position())





func knockback(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 1400 * delta)
	knockback = move_and_slide(knockback)
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.is_in_group("enemy"):
			AnimPlayer.play("hit")
			var enemy = collision.collider
			knockback = enemy.global_position.direction_to(self.global_position) * 700
			var damage = enemy.attack
			takeDamage(damage)
			

func takeDamage(damage):
	PlayerAttributes.health -= damage
	healthBar._on_health_updated(PlayerAttributes.health)
	healthBar.start()

func _on_player_died():
	queue_free()


func _on_Area2D_body_entered(body):
#	if(body.is_in_group("NPC")):
#		talkLabel.text = "Press Space to Talk"
#		talkLabel.visible = true
#		isAbleToTalk = true
#		npc = body
	if(body.is_in_group("TreasureChest")):
		talkLabel.text = "Press Space to Open"
		talkLabel.visible = true
		isAbleToOpen = true
		treasureChest = body

