extends Control

@onready var healthBar = $HealthBar
@onready var manaBar = $ManaBar
@onready var cooldownBar = $CooldownBar

func _ready():
	healthBar.max_value = PlayerStats.max_health
	healthBar.value = PlayerStats.health
	manaBar.max_value = PlayerStats.max_mana
	manaBar.value = PlayerStats.mana
	cooldownBar.max_value = PlayerStats.manaRegenTimer.wait_time
	cooldownBar.value = PlayerStats.manaRegenTimer.time_left

	PlayerStats.changed_health.connect(on_changed_health)
	PlayerStats.no_health.connect(on_no_health)
	PlayerStats.changed_mana.connect(on_changed_mana)

func _physics_process(delta):
	cooldownBar.value = PlayerStats.manaRegenTimer.wait_time - PlayerStats.manaRegenTimer.time_left

func on_changed_health(val):
	healthBar.value = val

func on_changed_mana(val):
	manaBar.value = val

func on_no_health():
	self.visible = false

	
