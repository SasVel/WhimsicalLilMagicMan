extends Node2D
@onready var BaseBullet = preload("res://Bullets/MagicBullet.tscn")
@onready var BigBullet = preload("res://Bullets/BigMagicBullet.tscn")
@onready var ExplosionBullet = preload("res://Bullets/ExplodingMagicBullet.tscn")


@onready var shootTimer = $ShootTimer
@onready var staff = self.get_parent().get_node("Staff")
var canShoot = true

@onready var whooshPlayer = $WhooshPlayer

enum spellEnum {
	BASE,
	BIG_BULLET,
	EXPLOSION_BULLET
}
var selectedSpell = spellEnum.EXPLOSION_BULLET

func shoot():
	if canShoot:
		match selectedSpell:
			spellEnum.BASE:
				bullet_spawn(BaseBullet)
			spellEnum.BIG_BULLET:
				bullet_spawn(BigBullet)
			spellEnum.EXPLOSION_BULLET:
				bullet_spawn(ExplosionBullet)
			
func bullet_spawn(Bullet):
	var bullet = Bullet.instantiate()
	if PlayerStats.mana >= bullet.mana_cost:
		bullet.position = staff.gemPos
		
		get_tree().get_root().add_child(bullet)
		
		whooshPlayer.play()
		shootTimer.start()
		canShoot = false

func _on_shoot_timer_timeout():
	canShoot = true
