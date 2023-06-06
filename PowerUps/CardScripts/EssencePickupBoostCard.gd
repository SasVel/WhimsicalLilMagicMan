extends Card

@onready var path = "res://World/Pickups/ManaPickup.tscn"
@onready var ManaPickupScene = load(path)

func _on_pressed():
	GlobalInfo.manaPickupEssenceMultiplier += GlobalInfo.manaPickupEssenceMultiplier * 0.2
	
