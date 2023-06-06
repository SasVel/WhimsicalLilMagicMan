extends Node2D

@onready var ManaPickup = preload("res://World/Pickups/ManaPickup.tscn")
@onready var spawnArea = $SpawnArea
@onready var spawnShape = $SpawnArea/CollisionShape2D
@export var pickupCount = 5
@onready var manaPickupEssenceMultiplier : float = 0

func _ready():
	GlobalInfo.room_change.connect(clear_old_pickups)
	GlobalInfo.mana_pickup_multiplier_changed.connect(set_multiplier)

func _on_pickups_timer_timeout():
	var pickups = spawnArea.get_overlapping_areas()
	var spawnSize = spawnShape.shape.size
	
	if pickups.size() < pickupCount:
		var randGlPosInShape = get_random_global_vec_in_size(spawnShape.global_position, spawnSize)
		spawn_pikcup(randGlPosInShape)

func get_random_global_vec_in_size(shapePos, shapeSize):
	var randVec = Vector2(randi_range(0, shapeSize.x), randi_range(0, shapeSize.y))
	var randGlPosInShape = shapePos / 2 + randVec
	return randGlPosInShape

func set_multiplier(val):
	manaPickupEssenceMultiplier = val

func spawn_pikcup(pos):
	var manaPickup = ManaPickup.instantiate() as ManaPickup
	manaPickup.mana_on_pickup *= manaPickupEssenceMultiplier
	
	manaPickup.global_position = pos
	get_tree().get_root().add_child(manaPickup)

func clear_old_pickups():
	var pickups = spawnArea.get_overlapping_areas()
	for pickup in pickups:
		pickup.queue_free()
