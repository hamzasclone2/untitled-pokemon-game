extends Node

var BasicEnemy = {
	health = 100,
	maxHealth =  100,
	speed = 200
}

var NPCs = {
	"BasicEnemy": BasicEnemy
}
# var cyclops = {
#	health = 100,
#	speed = 5,
#	weapon = "giant club"
#}

#load stats from NPC manager.

func get_health(name: String) -> float:
	return NPCs.get(name).health
	
func get_maxHealth(name: String) -> float:
	return NPCs.get(name).maxHealth
		
func get_speed(name: String) -> float:
	return NPCs.get(name).speed
