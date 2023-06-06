extends Node2D
@onready var BaseBullet = preload("res://MagicBullet/MagicBullet.tscn")
@onready var shootTimer = $ShootTimer
@onready var staff = self.get_parent().get_node("Staff")
var canShoot = true

@onready var whooshPlayer = $WhooshPlayer

enum spellEnum {
	BASE,
	BigBullet
}
var selectedSpell = spellEnum.BASE

func shoot():
	if canShoot:
		match selectedSpell:
			spellEnum.BASE:
				base_bullet_spawn()
			
		whooshPlayer.play()
		shootTimer.start()
		canShoot = false

func base_bullet_spawn():
	var bullet = BaseBullet.instantiate()
	if PlayerStats.mana >= bullet.mana_cost:
		bullet.position = staff.gemPos
		get_tree().get_root().add_child(bullet)

func _on_shoot_timer_timeout():
	canShoot = true
