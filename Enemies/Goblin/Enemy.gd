extends RigidBody2D

@onready var sprites = $MainSprite
@export var SPEED = 50

enum {
	IDLE,
	RUN
}
var state = IDLE

func _ready():
	GlobalInfo.world_state_changed.connect(world_state_changed)

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
	if GlobalInfo.playerPos.x > self.position.x:
		sprites.flip_h = false
	else:
		sprites.flip_h = true
	

func _on_player_detection_zone_body_entered(body):
	if body is Player:
		state = RUN

func _on_player_detection_zone_body_exited(body):
	if body is Player:
		state = IDLE

func world_state_changed(val):
	if val == 1:
		sprites.material.set_shader_parameter("flash_opacity", 0.7)
		sprites.material.set_shader_parameter("flash_color", Color.WHITE)
	else:
		sprites.material.set_shader_parameter("flash_opacity", 0)

func _on_hurt_box_area_entered(area):
	queue_free()
