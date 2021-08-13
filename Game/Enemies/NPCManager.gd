extends Node

var BasicEnemy = {
	health = 20,
	speed = 100
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
		
func get_speed(name: String) -> float:
	return NPCs.get(name).speed
