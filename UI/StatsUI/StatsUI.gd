extends Control

@onready var healthBar = $HealthBar
@onready var manaBar = $ManaBar
@onready var cooldownBar = $CooldownBar
@onready var spellSlot = $SpellSlot

@onready var BaseBullet = preload("res://Bullets/MagicBullet.tscn")
@onready var BigBullet = preload("res://Bullets/BigMagicBullet.tscn")
@onready var ExplosionBullet = preload("res://Bullets/ExplodingMagicBullet.tscn")

func _ready():
	update_health()
	update_mana()
	
	cooldownBar.max_value = PlayerStats.manaRegenTimer.wait_time
	cooldownBar.value = PlayerStats.manaRegenTimer.time_left

	PlayerStats.changed_health.connect(on_changed_health)
	PlayerStats.no_health.connect(on_no_health)
	PlayerStats.changed_mana.connect(on_changed_mana)
	
	SpellController.changed_spell.connect(on_changed_spell)

func _physics_process(delta):
	cooldownBar.value = PlayerStats.manaRegenTimer.wait_time - PlayerStats.manaRegenTimer.time_left

func on_changed_health(val):
	update_health()
	healthBar.value = val

func on_changed_mana(val):
	update_mana()
	manaBar.value = val

func on_no_health():
	self.visible = false

func update_health():
	healthBar.max_value = PlayerStats.max_health
	healthBar.value = PlayerStats.health

func update_mana():
	manaBar.max_value = PlayerStats.max_mana
	manaBar.value = PlayerStats.mana
	
func on_changed_spell(val):
	match val:
		SpellController.spellEnum.BASE:
			display_bullet(BaseBullet)
		SpellController.spellEnum.BIG_BULLET:
			display_bullet(BigBullet)
		SpellController.spellEnum.EXPLOSION_BULLET:
			display_bullet(ExplosionBullet)
			
func display_bullet(BulletScn):
	var bullet = BulletScn.instantiate() as Bullet
	var bulletParticles = bullet.get_node("GPUParticles2D")
	
	bullet.SPEED = 0
	bulletParticles.speed_scale = 0.3
	bullet.get_node("HitBox").monitorable = false
	bullet.get_node("HurtBox").monitoring = false
	
	bullet.position = Vector2(20, 20)
	bulletParticles.scale *= 2
	bulletParticles.process_material.scale_min *= 2
	bulletParticles.process_material.scale_max *= 2
	spellSlot.add_child(bullet)
