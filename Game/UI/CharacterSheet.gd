extends Control

onready var healthLabel = get_node("Background/M/Main/Middle/V/healthLabel")
onready var armorLabel = get_node("Background/M/Main/Middle/V/armorLabel")
onready var damageLabel = get_node("Background/M/Main/Middle/V/damageLabel")
onready var offDamageLabel = get_node("Background/M/Main/Middle/V/offDamageLabel")
onready var speedLabel = get_node("Background/M/Main/Middle/V/speedLabel")
onready var expLabel = get_node("Background/M/Main/Middle/V/expLabel")

func _process(delta):
	healthLabel.text = str(PlayerAttributes.health) + "/" + str(PlayerAttributes.maxHealth) + " HP"
	armorLabel.text = str(PlayerAttributes.armor) + " ARMOR"
	damageLabel.text = str(PlayerAttributes.damage) + " MAIN HAND DAMAGE"
	offDamageLabel.text = str(PlayerAttributes.off_damage) + " OFF HAND DAMAGE"
	speedLabel.text = str(PlayerAttributes.speed) + " SPEED"
	expLabel.text = str(PlayerAttributes.experience) + " EXP"
