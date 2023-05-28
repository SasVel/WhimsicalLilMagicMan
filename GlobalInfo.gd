extends Node2D

var playerPos : Vector2
signal world_state_changed(val)
signal room_change(doorVector)
signal game_completed

enum worldStateEnum {
	MAIN,
	MAGIC
}
var worldState = worldStateEnum.MAIN : set = set_world_state

func set_world_state(val):
	emit_signal("world_state_changed", val)
	worldState = val

func change_room(doorVector):
	emit_signal("room_change", doorVector)

func game_complete():
	emit_signal("game_completed")
