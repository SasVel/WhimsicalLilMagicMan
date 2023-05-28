extends Node2D
class_name Room

var isCompleted = false

func _on_final_area_body_entered(body):
	GlobalInfo.game_complete()
