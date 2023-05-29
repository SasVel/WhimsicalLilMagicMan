extends Card

func _on_pressed():
	PlayerStats.manaTickTimer.wait_time -= PlayerStats.manaTickTimer.wait_time * 0.25
