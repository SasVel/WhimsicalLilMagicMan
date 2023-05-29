extends Card

func _on_pressed():
	var player = get_tree().get_root().get_node("./Main/Player") as Player
	player.MAX_SPEED += player.MAX_SPEED * 0.2
