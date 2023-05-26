extends RigidBody2D

@onready var sprites = $MainSprite
@export var SPEED = 100
@export var MAX_SPEED = 300
var directionToPlayer = Vector2.ZERO
@onready var stats = $Stats

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
			idle_state(delta)
		RUN:
			sprites.animation = "Run"
			run_state(delta)
	directionToPlayer = self.position.direction_to(GlobalInfo.playerPos)

func idle_state(delta):
	if self.linear_velocity != Vector2.ZERO:
		self.linear_velocity = self.linear_velocity.move_toward(Vector2.ZERO, SPEED * delta)
	
func run_state(delta):
	if self.linear_velocity.x < MAX_SPEED || self.linear_velocity.y < MAX_SPEED:
		self.apply_central_impulse(directionToPlayer * SPEED * delta * 2)
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
	var entity = area.get_parent()
	self.apply_central_impulse(entity.velocity * 2)
	stats.health -= area.damage

func _on_stats_no_health():
	queue_free()
