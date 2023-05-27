extends ColorRect

var clearFog = true

func _process(delta):
	if clearFog:
		if self.color.a > 0:
			clear_fog()
	else:
		if self.color.a < 1:
			bring_fog()

func clear_fog():
	self.color.a -= 0.05
	
func bring_fog():
	self.color.a += 0.05
