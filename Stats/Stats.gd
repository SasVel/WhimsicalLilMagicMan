extends Node2D

signal no_health
signal changed_health(val)

@export var max_health = 1
var health : set = set_health

func _ready():
	health = max_health

func set_health(val):
	emit_signal("changed_health", val)
	health = clamp(val, 0, max_health + 1)
	if health <= 0:
		emit_signal("no_health")
