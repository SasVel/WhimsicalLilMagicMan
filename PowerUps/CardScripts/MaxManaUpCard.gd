extends Card

func _on_pressed():
	PlayerStats.max_mana += PlayerStats.max_mana * 0.2
