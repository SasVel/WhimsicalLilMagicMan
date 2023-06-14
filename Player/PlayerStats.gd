extends Node2D

signal no_health
signal changed_health(val)

signal no_mana
signal changed_mana(val)

@export var max_health : float = 10.0
@onready var init_max_health = max_health
var health : float : set = set_health

@export var max_mana : float = 40.0
@onready var init_max_mana = max_mana
var mana : float : set = set_mana
@export var mana_regen_per_tick = 1
@onready var init_mana_regen_per_tick = mana_regen_per_tick
@onready var manaTickTimer = $ManaTickTimer
@onready var init_mana_tick_time = manaTickTimer.wait_time
@onready var manaRegenTimer = $ManaRegenTimer
@onready var init_mana_regen_time = manaRegenTimer.wait_time
var canRegenerate = false : set = set_mana_regen_bool

func _ready():
	health = max_health
	mana = max_mana
	
func set_health(val):
	emit_signal("changed_health", val)
	health = clamp(val, 0, max_health)
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

func reset_stats():
	max_health = init_max_health
	max_mana = init_max_mana
	health = max_health
	mana = max_mana
	
	mana_regen_per_tick = init_mana_regen_per_tick
	manaTickTimer.wait_time = init_mana_tick_time
	manaRegenTimer.wait_time = init_mana_regen_time
