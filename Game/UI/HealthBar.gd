extends Control

onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween
onready var pulse_tween = $PulseTween
onready var shake_tween = $ShakeTween
onready var freq = $Frequency

export (Color) var healthy_color = Color.green
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red
export (Color) var pulse_color = Color.darkred
export (float, 0, 1, 0.05) var caution_zone = 0.5
export (float, 0, 1, 0.05) var danger_zone = 0.2
export (bool) var willPulse = false

var amplitude = 0

func _ready():
	if(get_parent().is_in_group("enemy")):
		health_over.value = NpcManager.get_health(get_parent().get_name())
		health_over.max_value = NpcManager.get_maxHealth(get_parent().get_name())
		health_under.value = NpcManager.get_health(get_parent().get_name())
		health_under.max_value = NpcManager.get_maxHealth(get_parent().get_name())
	else:
		willPulse = true
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
		if willPulse:
			pulse_tween.interpolate_property(health_over, "tint_progress", pulse_color, danger_color, 1.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			pulse_tween.start()
		health_over.tint_progress = danger_color
	elif health < health_over.max_value * caution_zone:
		health_over.tint_progress = caution_color
	else:
		health_over.tint_progress = healthy_color

func _on_max_health_updated(max_health):
	health_over.max_value = max_health

func start(duration = 0.2, frequency = 15, amplitude = 16):
	self.amplitude = amplitude
	
	$Duration.wait_time = duration
	$Frequency.wait_time = 1 /  float(frequency)
	$Duration.start()
	$Frequency.start()
	
	_new_shake()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	shake_tween.interpolate_property(self, "rect_position", self.rect_position, rand, freq.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	shake_tween.start()

func _reset():
	shake_tween.interpolate_property(self, "rect_position", self.rect_position, Vector2(), freq.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	shake_tween.start()

func _on_Frequency_timeout():
	_new_shake()


func _on_Duration_timeout():
	_reset()
	freq.stop()
