extends Bullet

@onready var explosionArea = $ExplosionRadius
@export var explosionStrength = 300
@onready var DeathEffect = preload("res://Effects/CustomEffects/ExplosionEffect.tscn")

func _on_hurt_box_body_entered(body):
	var entitiesColliding = explosionArea.get_overlapping_areas()
	for entity in entitiesColliding:
		if entity is HurtBox:
			var enemy = entity.get_parent()
			velocity = self.position.direction_to(enemy.position) * explosionStrength
			enemy._on_hurt_box_area_entered(explosionArea)
	
	spawn_death_effect()
	super(body)

func spawn_death_effect():
	var deathEffect = DeathEffect.instantiate()
	deathEffect.global_position = self.global_position
	get_tree().get_root().add_child(deathEffect)
