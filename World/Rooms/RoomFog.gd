extends CanvasLayer

var clearFog = true
@onready var fogRect = $RoomFogRect

func _process(delta):
	if clearFog:
		if fogRect.color.a > 0:
			clear_fog()
	else:
		if fogRect.color.a < 1.0:
			bring_fog()

func clear_fog():
	fogRect.color.a -= 0.05
	
func bring_fog():
	fogRect.color.a += 0.05
