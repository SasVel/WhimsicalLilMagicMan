extends ColorRect

var clearFog = false

func _process(delta):
	if clearFog:
		if self.color.a > 0:
			clear_fog()
	else:
		if self.color.a < 255:
			bring_fog()

func clear_fog():
	self.color.a -= 10
	
func bring_fog():
	self.color.a += 10
