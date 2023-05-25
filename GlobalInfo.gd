extends Node2D

var playerPos : Vector2
signal world_state_changed(val)

enum worldStateEnum {
	MAIN,
	MAGIC
}
var worldState = worldStateEnum.MAIN : set = set_world_state

func set_world_state(val):
	emit_signal("world_state_changed", val)
	worldState = val
