extends RigidBody2D

@onready var sprites = $MainSprite
@export var SPEED = 50


enum {
	IDLE,
	RUN
}
var state = IDLE

func _physics_process(delta):
	match state:
		IDLE:
			sprites.animation = "Idle"
			idle_state()
		RUN:
			sprites.animation = "Run"
			run_state(delta)
	

func idle_state():
	pass
	
func run_state(delta):
	self.position = self.position.move_toward(GlobalInfo.playerPos, SPEED * delta)

func _on_player_detection_zone_body_entered(body):
	if body is Player:
		state = RUN

func _on_player_detection_zone_body_exited(body):
	if body is Player:
		state = IDLE
