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

