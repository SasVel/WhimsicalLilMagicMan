extends Control

@onready var healthBar = $HealthBar
@onready var manaBar = $ManaBar
@onready var cooldownBar = $CooldownBar
@onready var spellSlot = $SpellSlot

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
	
func on_changed_spell(spellEnumVal):
	clear_bullet()
	display_bullet(SpellHelper.spell_enum_to_model(spellEnumVal))
			
func display_bullet(BulletScn):
	var bullet = BulletScn.instantiate() as Bullet
	bullet = SpellHelper.convert_spell_for_display(bullet)
	
	bullet.position = Vector2(20, 20)
	spellSlot.add_child(bullet)

func clear_bullet():
	var spellSlotChildren = spellSlot.get_children()
	for child in spellSlotChildren:
		spellSlot.remove_child(child)
