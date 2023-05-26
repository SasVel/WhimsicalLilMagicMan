extends Control

@onready var healthBar = $HealthBar

func _ready():
	healthBar.max_value = PlayerStats.max_health
	healthBar.value = PlayerStats.health

	PlayerStats.changed_health.connect(on_changed_health)
	PlayerStats.no_health.connect(on_no_health)

func on_changed_health(val):
	healthBar.value = val

func on_no_health():
	self.visible = false
