extends Card

@onready var path = "res://World/Pickups/ManaPickup.tscn"
@onready var ManaPickupScene = load(path)

func _on_pressed():
	var manaPickup = ManaPickupScene.instantiate() as ManaPickup
	manaPickup.mana_on_pickup += manaPickup.mana_on_pickup * 0.2
	var scene = PackedScene.new().pack(manaPickup)
	ResourceSaver.save(scene, path)
