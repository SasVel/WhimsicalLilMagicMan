extends CharacterBody2D

@export var SPEED = 300
@export var mana_cost = 10
var direction = Vector2.ZERO

func _ready():
	direction = self.position.direction_to(get_global_mouse_position())
	PlayerStats.mana -= mana_cost

func _physics_process(delta):
	velocity = direction * SPEED
	move_and_slide()
	

func _on_hurt_box_area_entered(area):
	queue_free()
