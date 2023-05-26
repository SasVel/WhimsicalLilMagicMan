extends Node2D

signal no_health
signal changed_health(val)

signal no_mana
signal changed_mana(val)

@export var max_health = 10
@export var max_mana = 10
@export var mana_regen_per_tick = 1
var health : set = set_health

var mana = 0 : set = set_mana
@onready var manaTickTimer = $ManaTickTimer
@onready var manaRegenTimer = $ManaRegenTimer
var canRegenerate = false : set = set_mana_regen_bool

func _ready():
	health = max_health
	mana = max_mana

func set_health(val):
	emit_signal("changed_health", val)
	health = clamp(val, 0, max_health + 1)
	if health <= 0:
		emit_signal("no_health")

func set_mana(val):
	if mana > val:
		canRegenerate = false
		manaRegenTimer.start()
	
	emit_signal("changed_mana", val)
	mana = clamp(val, 0, max_mana)
	if mana <= 0:
		emit_signal("no_mana")
	
func _on_mana_regen_timer_timeout():
	canRegenerate = true

func set_mana_regen_bool(val):
	if canRegenerate != val:
		if val == true:
			manaTickTimer.start()
		else:
			manaTickTimer.stop()
	canRegenerate = val

func _on_mana_tick_timer_timeout():
	mana += mana_regen_per_tick
