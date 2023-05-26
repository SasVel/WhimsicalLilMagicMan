extends Area2D

@export var mana_on_pickup = 30

func _ready():
	GlobalInfo.world_state_changed.connect(pickup_activation)
	self.visible = false


func pickup_activation(val):
	if val:
		self.monitoring = true
		self.visible = true
	else:
		self.monitoring = false
		self.visible = false

func _on_area_entered(area):
	PlayerStats.mana += mana_on_pickup
	queue_free()
