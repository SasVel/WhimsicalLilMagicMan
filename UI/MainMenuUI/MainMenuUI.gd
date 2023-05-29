extends Control


func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://World/Main.tscn")

func _on_settings_btn_pressed():
	get_tree().change_scene_to_file("res://UI/SettingsUI/SettingsUI.tscn")

func _on_credits_btn_pressed():
	get_tree().change_scene_to_file("res://UI/CreditsUI/CreditsUI.tscn")
