extends Node


# XP needed to complete a level
func xpNeeded(level: int) -> int:
	return int(round(((pow(level-1,2))/75.0)+10))
	# xpNeeded = ((1/75) * (level - 1)^2) + 10

