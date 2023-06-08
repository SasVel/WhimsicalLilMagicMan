extends Node2D

@onready var spells = [Loader.BigBullet, Loader.ExplosionBullet]
@onready var selectedSpell = spells[randi_range(0, spells.size() - 1)]
@onready var interactArea = $InteractableArea
@onready var playerInArea = false
@onready var animPlayer = $AnimationPlayer
@onready var lootUI = $LootUI
@onready var lootCard = $LootUI/LootCard

signal chest_opened(spell)
func _ready():
	GlobalInfo.room_change.connect(clear_chest)

func _input(event):
	if Input.is_action_just_pressed("interact") && playerInArea:
		animPlayer.play("chest_open")

func _on_animation_player_animation_finished(anim_name):
	var spell = SpellHelper.convert_spell_for_display(selectedSpell.instantiate())
	lootCard.add_child(spell)
	
	lootUI.visible = true
	#get_tree().paused = true
	
func _on_interactable_area_body_entered(body):
	playerInArea = true

func _on_interactable_area_body_exited(body):
	playerInArea = false
	
func clear_chest(val):
	self.queue_free()

func _on_loot_card_pressed():
	pass # Replace with function body.
