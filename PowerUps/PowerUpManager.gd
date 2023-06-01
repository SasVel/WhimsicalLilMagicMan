extends Control

@onready var cardPositions = [$Card1, $Card2, $Card3]
var possibleCards = []

func _ready():
	self.visible = false
	EnemyTracker.no_enemies.connect(display_cards)
	load_cards()
	

func load_cards():
	var path = "res://PowerUps/Cards/"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			possibleCards.append(load(path + fileName))
			fileName = dir.get_next()

func display_cards():
	self.visible = true
	get_tree().paused = true
	for cardPos in cardPositions:
		var card = possibleCards.pick_random()
		if card != null:
			card = card.instantiate() as Card
			card.pressed.connect(on_card_pressed)
			cardPos.add_child(card)
			

func on_card_pressed():
	self.visible = false
	get_tree().paused = false
	for cardPos in cardPositions:
		var cardToRemove = cardPos.get_children()
		cardToRemove.clear()
