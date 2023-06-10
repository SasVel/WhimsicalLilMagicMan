extends Node
class_name SpellHelper

static func convert_spell_for_display(bullet) -> Bullet:
	var bulletParticles = bullet.get_node("GPUParticles2D")
	
	bullet.SPEED = 0
	bulletParticles.speed_scale = 0.3
	bullet.get_node("HitBox").monitorable = false
	bullet.get_node("HurtBox").monitoring = false
	
	bulletParticles.scale *= 2
	bulletParticles.process_material.scale_min *= 2
	bulletParticles.process_material.scale_max *= 2
	return bullet

static func spell_enum_to_model(spell_enum) -> PackedScene:
	match spell_enum:
		SpellController.spellEnum.BASE:
			return Loader.BaseBullet
		SpellController.spellEnum.BIG_BULLET:
			return Loader.BigBullet
		SpellController.spellEnum.EXPLOSION_BULLET:
			return Loader.ExplosionBullet
	return null

static func spell_model_to_enum(spell_model):
	#spell_model = spell_model as Bullet
	match spell_model.instantiate().enum_bullet_name:
		"BaseBullet":
			return SpellController.spellEnum.BASE
		"BigBullet":
			return SpellController.spellEnum.BIG_BULLET
		"ExplosionBullet":
			return SpellController.spellEnum.EXPLOSION_BULLET
	return null
