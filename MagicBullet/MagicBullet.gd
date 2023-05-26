extends CharacterBody2D

@export var SPEED = 300
@export var bounceCount = 2
var direction = Vector2.ZERO

func _ready():
	direction = self.position.direction_to(get_global_mouse_position())

func _physics_process(delta):
	velocity = direction * SPEED
	move_and_slide()
	

func _on_hurt_box_area_entered(area):
	queue_free()

func _on_hurt_box_body_entered(body):
	pass # Replace with function body.
