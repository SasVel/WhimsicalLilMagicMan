extends Control

@onready var masterSlider = $MasterSlider
@onready var musicSlider = $MusicSlider
@onready var sfxSlider = $SFXSlider

func _ready():
	masterSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	musicSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	sfxSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))

func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
