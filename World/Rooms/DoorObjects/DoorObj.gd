extends Area2D

enum directions {
	UP, DOWN, LEFT, RIGHT
}
@export var direction : directions
var directionVector
signal player_entered
var playerInArea = false

func _ready():
	EnemyTracker.no_enemies.connect(on_no_enemies)
	match direction:
		directions.UP:
			directionVector = Vector2.UP
		directions.DOWN:
			directionVector = Vector2.DOWN
		directions.LEFT:
			directionVector = Vector2.LEFT
		directions.RIGHT:
			directionVector = Vector2.RIGHT
			

func _physics_process(delta):
	if playerInArea:
		if Input.is_action_just_pressed("interact"):
			GlobalInfo.change_room(directionVector)

func on_no_enemies():
	self.monitoring = true

func _on_body_entered(body):
	playerInArea = true
	
func _on_body_exited(body):
	playerInArea = false
