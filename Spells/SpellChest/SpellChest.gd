extends Node2D
class_name SpellChest

@onready var spells = [Loader.BigBullet, Loader.ExplosionBullet]
@onready var selectedSpell = spells[randi_range(0, spells.size() - 1)]
@onready var interactArea = $InteractableArea
@onready var playerInArea = false
@onready var animPlayer = $AnimationPlayer


signal chest_opened(spell)
func _ready():
	GlobalInfo.room_change.connect(clear_chest)

func _input(event):
	if Input.is_action_just_pressed("interact") && playerInArea:
		animPlayer.play("chest_open")

func _on_animation_player_animation_finished(anim_name):
	emit_signal("chest_opened", selectedSpell)
	
func _on_interactable_area_body_entered(body):
	playerInArea = true

func _on_interactable_area_body_exited(body):
	playerInArea = false
	
func clear_chest(val):
	self.queue_free()
