extends TextureButton

@onready var label = $BtnLabel

func _on_button_down():
	label.position += Vector2.DOWN * 3

func _on_button_up():
	label.position += Vector2.UP * 3
