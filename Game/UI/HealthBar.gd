extends Control

onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween

export (Color) var healthy_color = Color.green
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red
export (float, 0, 1, 0.05) var caution_zone = 0.5
export (float, 0, 1, 0.05) var danger_zone = 0.2

func _ready():
	if(get_parent().is_in_group("enemy")):
		health_over.value = NpcManager.get_health(get_parent().get_name())
		health_over.max_value = NpcManager.get_maxHealth(get_parent().get_name())
		health_under.value = NpcManager.get_health(get_parent().get_name())
		health_under.max_value = NpcManager.get_maxHealth(get_parent().get_name())
	else:
		health_over.value = PlayerAttributes.health
		health_over.max_value = PlayerAttributes.maxHealth
		health_under.value = PlayerAttributes.health
		health_under.max_value = PlayerAttributes.maxHealth

func _on_health_updated(health):
	health_over.value = health
	update_tween.interpolate_property(health_under, "value", health_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	update_tween.start()
	_assign_color(health)
	
func _assign_color(health):
	if health < health_over.max_value * danger_zone:
		health_over.tint_progress = danger_color
	elif health < health_over.max_value * caution_zone:
		health_over.tint_progress = caution_color
	else:
		health_over.tint_progress = healthy_color
func _on_max_health_updated(max_health):
	health_over.max_value = max_health
