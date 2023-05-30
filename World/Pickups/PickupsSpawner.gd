extends Node2D

@onready var ManaPickup = preload("res://World/Pickups/ManaPickup.tscn")
@onready var spawnArea = $SpawnArea
@onready var spawnShape = $SpawnArea/CollisionShape2D
@export var pickupCount = 5

#func _ready():
#	GlobalInfo.room_change.connect(clear_old_pickups)

func _on_pickups_timer_timeout():
	var pickups = spawnArea.get_overlapping_areas()
	var spawnSize = spawnShape.shape.size
	
	if pickups.size() < pickupCount:
		var randGlPosInShape = get_random_global_vec_in_size(spawnShape.global_position, spawnSize)
		var manaPickup = ManaPickup.instantiate()
		manaPickup.global_position = randGlPosInShape
		get_tree().get_root().add_child(manaPickup)

func get_random_global_vec_in_size(shapePos, shapeSize):
	var randVec = Vector2(randi_range(0, shapeSize.x), randi_range(0, shapeSize.y))
	var randGlPosInShape = shapePos / 2 + randVec
	return randGlPosInShape

#func clear_old_pickups():
#	var pickups = spawnArea.get_overlapping_areas()
#	for pickup in pickups:
#		pickup.queue_free()
