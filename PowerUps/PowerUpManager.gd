extends Control

@onready var cardPositions = [$CardPos1, $CardPos2, $CardPos3]
var possibleCards = []

func _ready():
	self.visible = false
	EnemyTracker.no_enemies.connect(display_cards)
	load_cards()

func load_cards():
	var path = "res://PowerUps/Cards/"
	var cardCounter = 0
	while cardCounter != null:
		cardCounter += 1
		var pathToCard = path + "Card" + str(cardCounter) + ".tscn"
		if !FileAccess.file_exists(pathToCard):
			cardCounter = null
			break
		else:
			var card = load(pathToCard)
			possibleCards.append(card)

func display_cards():
	self.visible = true
	get_tree().paused = true
	for cardPos in cardPositions:
		var card = possibleCards.pick_random()
		if card != null:
			card = card.instantiate() as Card
			card.pressed.connect(on_card_pressed)
			#card.position = Vector2.ZERO
			cardPos.add_child(card)
			

func on_card_pressed():
	self.visible = false
	get_tree().paused = false
	for cardPos in cardPositions:
		var cardToRemove = cardPos.get_children()
		cardToRemove.clear()


