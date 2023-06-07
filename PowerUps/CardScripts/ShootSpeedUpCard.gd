extends Card

func _on_pressed():
	SpellController.shootTimer.wait_time -= SpellController.shootTimer.wait_time * 0.1

