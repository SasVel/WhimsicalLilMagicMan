extends Card

func _on_pressed():
	var player = get_tree().get_root().get_node("./Main/Player") as Player
	player.spellsController.shootTimer.wait_time -= player.spellsController.shootTimer.wait_time * 0.1

