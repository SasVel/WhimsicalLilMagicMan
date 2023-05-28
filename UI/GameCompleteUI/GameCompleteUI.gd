extends Control

func _ready():
	GlobalInfo.game_completed.connect(showUI)
	self.visible = false

func _on_restart_btn_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://World/Main.tscn")

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MainMenuUI/MainMenuUI.tscn")

func showUI():
	self.visible = true
	get_tree().paused = true
