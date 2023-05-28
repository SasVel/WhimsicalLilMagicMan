extends CharacterBody2D
class_name Player

@export var ACCELERATION = 60;
@export var FRICTION = 40;
@export var SPEED = 500;
@export var MAX_SPEED = 1500;
var CURR_SPEED = SPEED;
@onready var staff = $Staff
@onready var Bullet = preload("res://MagicBullet/MagicBullet.tscn")
@onready var whooshPlayer = $WhooshPlayer

enum {
	IDLE,
	MOVE
}
var state = MOVE

@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var lastDirection = Vector2(1, 0)
@onready var input_direction = Vector2.ZERO

func _ready():
	PlayerStats.no_health.connect(on_no_health)

func idle_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, (FRICTION * delta) * 20)
	
	if input_direction != Vector2.ZERO:
		state = MOVE

func move_state(delta):
	#Blend positions
	animationTree.set("parameters/Idle/blend_position", lastDirection)
	animationTree.set("parameters/Run/blend_position", input_direction)
	
	var input_vector = input_direction * (CURR_SPEED * delta) * 10
	
	if input_direction != Vector2.ZERO:
		if CURR_SPEED < MAX_SPEED:
			CURR_SPEED += ACCELERATION
		
		velocity = input_vector
		
		lastDirection = input_direction
		animationState.travel("Run")
	else:
		if CURR_SPEED > MAX_SPEED:
			CURR_SPEED -= FRICTION
		else:
			CURR_SPEED = SPEED
		
		state = IDLE
		animationState.travel("Idle")
		

func _physics_process(delta):
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	match state:
		IDLE:
			idle_state(delta)
		MOVE:
			move_state(delta)
	
	if Input.is_action_just_pressed("world_change"):
		if GlobalInfo.worldState == GlobalInfo.worldStateEnum.MAIN:
			GlobalInfo.worldState = GlobalInfo.worldStateEnum.MAGIC
		else:
			GlobalInfo.worldState = GlobalInfo.worldStateEnum.MAIN
	
	if Input.is_action_just_pressed("shoot") && GlobalInfo.worldState == GlobalInfo.worldStateEnum.MAIN:
		shoot()
	
	GlobalInfo.playerPos = self.position
	move_and_slide()
	
func shoot():
	var bullet = Bullet.instantiate()
	if PlayerStats.mana >= bullet.mana_cost:
		bullet.position = staff.gemPos
		get_tree().get_root().add_child(bullet)
		whooshPlayer.play()
		

func _on_hurt_box_area_entered(area):
	PlayerStats.health -= area.damage
	var enemy = area.get_parent()
	enemy.apply_central_impulse(Vector2(enemy.directionToPlayer * -1 * 800))

func on_no_health():
	queue_free()
