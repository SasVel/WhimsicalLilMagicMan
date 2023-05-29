extends Card

func _on_pressed():
	var player = get_tree().get_root().get_node("./Main/Player") as Player
	player.shootTimer.wait_time -= player.shootTimer.wait_time * 0.1

