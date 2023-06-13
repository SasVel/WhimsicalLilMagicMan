extends Node
class_name SpellHelper

static func convert_spell_for_display(bullet) -> Bullet:
	var bulletParticles = bullet.get_node("GPUParticles2D")
	
	bullet.SPEED = 0
	bullet.get_node("HitBox").monitorable = false
	bullet.get_node("HurtBox").monitoring = false
	
	bulletParticles.scale *= 1.5
	bulletParticles.speed_scale = 0.3
	bulletParticles.process_material.scale_min *= 1.5
	bulletParticles.process_material.scale_max *= 1.5
	
	if bullet.has_node("GPUParticles2D2"):
		var bulletParticles2 = bullet.get_node("GPUParticles2D2")
		bulletParticles2.scale *= 1.5
		bulletParticles2.speed_scale = 0.3
		bulletParticles2.process_material.scale_min *= 1.5
		bulletParticles2.process_material.scale_max *= 1.5
	
	return bullet

static func spell_enum_to_model(spell_enum) -> PackedScene:
	match spell_enum:
		SpellController.spellEnum.BASE:
			return Loader.BaseBullet
		SpellController.spellEnum.BIG_BULLET:
			return Loader.BigBullet
		SpellController.spellEnum.EXPLOSION_BULLET:
			return Loader.ExplosionBullet
		SpellController.spellEnum.DOUBLE_BULLET:
			return Loader.DoubleBullet
	return null

static func spell_model_to_enum(spell_model):
	match spell_model.instantiate().enum_bullet_name:
		"BaseBullet":
			return SpellController.spellEnum.BASE
		"BigBullet":
			return SpellController.spellEnum.BIG_BULLET
		"ExplosionBullet":
			return SpellController.spellEnum.EXPLOSION_BULLET
		"DoubleBullet":
			return SpellController.spellEnum.DOUBLE_BULLET
	return null
