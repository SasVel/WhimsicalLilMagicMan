extends Node2D

@onready var shootTimer = $ShootTimer
@onready var staff
var canShoot = true

@onready var whooshPlayer = $WhooshPlayer

signal changed_spell(val)
enum spellEnum {
	BASE,
	BIG_BULLET,
	EXPLOSION_BULLET,
	DOUBLE_BULLET
}
@onready var selectedSpell : set = set_spell
@onready var selectedSpellModel
@onready var SpellChest = preload("res://Spells/SpellChest/SpellChest.tscn")

func _ready():
	EnemyTracker.no_enemies.connect(spawn_spell_chest)

func set_spell(val):
	emit_signal("changed_spell", val)
	selectedSpell = val

func shoot():
	if canShoot:
		bullet_spawn(SpellHelper.spell_enum_to_model(selectedSpell))
			
func bullet_spawn(BulletScn):
	var bullet = BulletScn.instantiate()
	if PlayerStats.mana >= bullet.mana_cost:
		bullet.position = staff.gemPos
		bullet.rotation = staff.rotation
		get_tree().get_root().add_child(bullet)
		
		whooshPlayer.play()
		shootTimer.start()
		canShoot = false

func _on_shoot_timer_timeout():
	canShoot = true

func spawn_spell_chest():
	if get_tree().get_root().has_node("/root/Main"):
		var mainScn = get_tree().get_root().get_node("/root/Main")
		if mainScn.roomCounter % 3 == 0 && mainScn.roomCounter > 0:
			var spellChest = SpellChest.instantiate()
			spellChest.global_position = Vector2(336, 176)
			mainScn.add_child(spellChest)
			mainScn.move_child(spellChest, 3)
