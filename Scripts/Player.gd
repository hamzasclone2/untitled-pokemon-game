extends KinematicBody2D

var velocity = Vector2()
onready var sword = $Sword
onready var bow = $Bow

func get_input():
	if Input.is_action_just_pressed("click"):
		if PlayerAttributes.current_weapon == "sword":
			sword.attack()
	velocity = Vector2()
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	
	if Input.is_action_just_pressed("slot 1"):
		#For now will be forced to sword
		if PlayerAttributes.current_weapon != "sword":
			PlayerAttributes.current_weapon = "sword"
			sword.visible = true
			bow.visible = false
			print ("Current equipped weapon: ", PlayerAttributes.current_weapon)
	if Input.is_action_just_pressed("slot 2"):
		#For now will be forced to bow
		if PlayerAttributes.current_weapon != "bow":
			PlayerAttributes.current_weapon = "bow"
			bow.visible = true
			sword.visible = false
			print ("Current equipped weapon: ", PlayerAttributes.current_weapon)
	if Input.is_action_just_pressed("slot 3"):
		if PlayerAttributes.current_weapon != "empty":
			PlayerAttributes.current_weapon = "empty"
			bow.visible = false
			sword.visible = false
			print ("Current equipped weapon: ", PlayerAttributes.current_weapon)
			
	velocity = velocity.normalized() * PlayerAttributes.speed
	

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	look_at(get_global_mouse_position())
