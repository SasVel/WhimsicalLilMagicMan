extends "res://Bullets/Bullet.gd"
@onready var explosionArea = $ExplosionRadius
@export var explosionStrength = 1

func _on_hurt_box_body_entered(body):
	var entitiesColliding = explosionArea.get_overlapping_bodies()
	for entity in entitiesColliding:
		if entity.get_node_or_null("Stats") != null:
			entity.get_node("Stats").health -= explosionStrength
	
	super(body)
