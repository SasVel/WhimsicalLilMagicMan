extends Control

@onready var lootCard = $LootCard
@onready var header = lootCard.get_node("./Background/Header")
@onready var mainText = lootCard.get_node("./Background/MainText")

@onready var spell_model
func _ready():
	EnemyTracker.no_enemies.connect(connect_ui_to_chest)

func connect_ui_to_chest():
	var main = get_tree().get_root().get_node("/root/Main")
	if main.has_node("./SpellChest"):
		var spellChest = main.get_node("./SpellChest") as SpellChest
		spellChest.chest_opened.connect(display_loot_card)
	

func display_loot_card(selectedSpell):
	spell_model = selectedSpell
	
	self.visible = true
	get_tree().paused = true
	var spell = SpellHelper.convert_spell_for_display(selectedSpell.instantiate())
	spell.position = Vector2(lootCard.size.x / 2, lootCard.size.y / 2)
	header.text = spell.display_name
	mainText.text = spell.description
	lootCard.add_child(spell)

func _on_loot_card_pressed():
	SpellController.selectedSpell = SpellHelper.spell_model_to_enum(spell_model)
	clear_card()

func _on_keep_current_btn_pressed():
	clear_card()

func clear_card():
	self.visible = false
	get_tree().paused = false
	var cardChildren = lootCard.get_children()
	for child in cardChildren:
		lootCard.remove_child(child)
	header.text = ""
	mainText.text = ""
	
