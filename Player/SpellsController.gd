extends Node2D

@onready var BaseBullet = preload("res://Bullets/MagicBullet.tscn")
@onready var BigBullet = preload("res://Bullets/BigMagicBullet.tscn")
@onready var ExplosionBullet = preload("res://Bullets/ExplodingMagicBullet.tscn")

@onready var shootTimer = $ShootTimer
@onready var staff
var canShoot = true

@onready var whooshPlayer = $WhooshPlayer

signal changed_spell(val)
enum spellEnum {
	BASE,
	BIG_BULLET,
	EXPLOSION_BULLET
}
@onready var selectedSpell : set = set_spell
@onready var selectedSpellModel

func set_spell(val):
	emit_signal("changed_spell", val)
	selectedSpell = val

func shoot():
	if canShoot:
		match selectedSpell:
			spellEnum.BASE:
				bullet_spawn(BaseBullet)
			spellEnum.BIG_BULLET:
				bullet_spawn(BigBullet)
			spellEnum.EXPLOSION_BULLET:
				bullet_spawn(ExplosionBullet)
			
func bullet_spawn(BulletScn):
	var bullet = BulletScn.instantiate()
	if PlayerStats.mana >= bullet.mana_cost:
		bullet.position = staff.gemPos
		
		get_tree().get_root().add_child(bullet)
		
		whooshPlayer.play()
		shootTimer.start()
		canShoot = false

func _on_shoot_timer_timeout():
	canShoot = true
