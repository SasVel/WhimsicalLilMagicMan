extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	PlayerStats.no_health.connect(on_no_health)
	
func on_no_health():
	self.visible = true
	get_tree().paused = true

func _on_restart_btn_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_main_menu_btn_pressed():
	get_tree().change_scene_to_file("res://UI/MainMenuUI/MainMenuUI.tscn")
