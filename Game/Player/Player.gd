extends KinematicBody2D

var velocity = Vector2()
var knockback = Vector2.ZERO
onready var sword = $Sword
onready var bow = $Bow
onready var spear = $Spear
onready var AnimPlayer = $AnimationPlayer

var weapons = ["empty", "sword", "spear", "bow"]
var weaponsIndex = 0
var isAbleToTalk = false
var npc
onready var talkLabel = get_tree().root.get_node("Test/UserInterface/TalkLabel")

func get_input():
	if Input.is_action_just_pressed("click"):
		if PlayerAttributes.current_weapon == "sword":
			sword.attack()
		if PlayerAttributes.current_weapon == "bow":
			bow.shoot()
		if PlayerAttributes.current_weapon == "spear":
			spear.attack()
	velocity = Vector2()
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	
	if(Input.is_action_just_released("scrollWheelUp")):
		weaponsIndex += 1
		if(weaponsIndex >= weapons.size()):
			weaponsIndex = 0
		PlayerAttributes.current_weapon = weapons[weaponsIndex]
		
	if(Input.is_action_just_released("scrollWheelDown")):
		weaponsIndex -= 1
		if(weaponsIndex < 0):
			weaponsIndex = weapons.size() - 1
		PlayerAttributes.current_weapon = weapons[weaponsIndex]
		
		
	if Input.is_action_just_pressed("slot 1"):
		#For now will be forced to sword
		if PlayerAttributes.current_weapon != "sword":
			PlayerAttributes.current_weapon = "sword"

			print ("Current equipped weapon: ", PlayerAttributes.current_weapon)
	if Input.is_action_just_pressed("slot 2"):
		if PlayerAttributes.current_weapon != "spear":
			PlayerAttributes.current_weapon = "spear"

	if Input.is_action_just_pressed("slot 3"):
		#For now will be forced to bow
		if PlayerAttributes.current_weapon != "bow":
			PlayerAttributes.current_weapon = "bow"

			print ("Current equipped weapon: ", PlayerAttributes.current_weapon)
	if Input.is_action_just_pressed("slot 4"):
		if PlayerAttributes.current_weapon != "empty":
			PlayerAttributes.current_weapon = "empty"
			print ("Current equipped weapon: ", PlayerAttributes.current_weapon)
			
	velocity = velocity.normalized() * PlayerAttributes.speed
	

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	knockback(delta)
	look_at(get_global_mouse_position())
	if PlayerAttributes.current_weapon == "sword":
		sword.visible = true
		bow.visible = false
		spear.visible = false
	elif PlayerAttributes.current_weapon == "spear":
		sword.visible = false
		bow.visible = false
		spear.visible = true
	elif PlayerAttributes.current_weapon == "bow":
		sword.visible = false
		bow.visible = true
		spear.visible = false
	elif PlayerAttributes.current_weapon == "empty":
		sword.visible = false
		bow.visible = false
		spear.visible = false
		
	if(isAbleToTalk):
		talkLabel.visible = true
		if(Input.is_action_pressed("ui_accept")):
			npc.talk()
			talkLabel.visible = false
	
	

func knockback(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 500 * delta)
	knockback = move_and_slide(knockback)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.is_in_group("enemy"):
			AnimPlayer.play("hit")
			var enemy = collision.collider
			knockback = enemy.global_position.direction_to(self.global_position) * 300
			var damage = enemy.attack
			takeDamage(damage)

func takeDamage(damage):
	PlayerAttributes.health -= damage
	if(PlayerAttributes.health < 0):
		pass
		#Eventually this is where you would die

func _on_Area2D_body_entered(body):
	if(body.is_in_group("NPC")):
		isAbleToTalk = true
		npc = body


func _on_Area2D_body_exited(body):
	isAbleToTalk = false
	talkLabel.visible = false
