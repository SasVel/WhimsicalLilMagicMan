extends Control

var isPaused = false
func _ready():
	self.visible = false
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if isPaused:
			resume_game()
		else:
			pause_game()
			
func pause_game():
	isPaused = true
	self.visible = true
	get_tree().paused = true
	
func resume_game():
	isPaused = false
	self.visible = false
	get_tree().paused = false
