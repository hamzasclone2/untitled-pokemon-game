extends KinematicBody2D

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
	velocity = Vector2()
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	
	velocity = velocity.normalized() * PlayerAttributes.speed
	

func _physics_process(delta):
	if(PlayerAttributes.equipment_data["MainHand"] == null):
		sword.visible = false
	if(PlayerAttributes.equipment_data["OffHand"] ==  null):
		bow.visible = false
	get_input()
	move_and_slide(velocity)
	knockback(delta)
	look_at(get_global_mouse_position())
		
	if(isAbleToTalk):
		if(Input.is_action_just_pressed("ui_accept")):
			isAbleToTalk = false
			talkLabel.visible = false
			npc.talk()

	if(isAbleToOpen):
		if(Input.is_action_just_pressed("ui_accept")):
			treasureChest.open()
			isAbleToOpen = false
	
	

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
	if(PlayerAttributes.health <= 0):
		queue_free()

func _on_Area2D_body_entered(body):
	if(body.is_in_group("NPC")):
		talkLabel.text = "Press Space to Talk"
		talkLabel.visible = true
		isAbleToTalk = true
		npc = body
	elif(body.is_in_group("TreasureChest")):
		talkLabel.text = "Press Space to Open"
		talkLabel.visible = true
		isAbleToOpen = true
		treasureChest = body


func _on_Area2D_body_exited(body):
	isAbleToTalk = false
	talkLabel.visible = false
