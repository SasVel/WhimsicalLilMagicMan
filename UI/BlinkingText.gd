extends Label

#The Script needs a BlinkTimer as a child of the label
@onready var blinkTimer = $BlinkTimer

func _on_blink_timer_timeout():
	if self.visible == true:
		self.visible = false
	else:
		self.visible = true
