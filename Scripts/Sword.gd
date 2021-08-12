extends Area2D

signal attack_finished

onready var animation_player = $AnimationPlayer

enum STATES {IDLE, ATTACK}
var current_state = STATES.IDLE

var bodies_hit = []

func _ready():
	set_physics_process(false)
	
func attack():
	_change_state(STATES.ATTACK)
	
	
func _change_state(new_state):
	current_state = new_state
	match current_state:
		STATES.IDLE:
			bodies_hit = []
			set_physics_process(false)
		STATES.ATTACK:
			set_physics_process(true)
			animation_player.play("attack")
			
func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
	for body in overlapping_bodies:
		if body.is_in_group("enemy") && not bodies_hit.has(body.name):
			body.take_damage(PlayerAttributes.swordDamage)
			bodies_hit.append(body.name)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		_change_state(STATES.IDLE)
		emit_signal("attack_finished")
