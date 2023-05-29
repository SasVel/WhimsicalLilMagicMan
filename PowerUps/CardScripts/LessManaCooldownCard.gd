extends Card


func _on_pressed():
	PlayerStats.manaRegenTimer.wait_time -= PlayerStats.manaRegenTimer.wait_time * 0.25
