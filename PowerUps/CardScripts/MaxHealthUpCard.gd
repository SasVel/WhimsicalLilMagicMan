extends Card


func _on_pressed():
	var currHealth = PlayerStats.health
	PlayerStats.max_health += PlayerStats.max_health * 0.2
	PlayerStats.health = currHealth
