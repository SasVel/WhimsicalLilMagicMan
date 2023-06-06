extends Node2D

var playerPos : Vector2
signal world_state_changed(val)
signal room_change(doorVector)
signal game_completed

var manaPickupEssenceMultiplier : float = 1 : set = set_mana_pickup_multiplier
signal mana_pickup_multiplier_changed

enum worldStateEnum {
	MAIN,
	MAGIC
}
var worldState = worldStateEnum.MAIN : set = set_world_state

func set_world_state(val):
	emit_signal("world_state_changed", val)
	worldState = val

func set_mana_pickup_multiplier(val):
	emit_signal("mana_pickup_multiplier_changed", val)
	manaPickupEssenceMultiplier = val

func change_room(doorVector):
	emit_signal("room_change", doorVector)

func game_complete():
	emit_signal("game_completed")
