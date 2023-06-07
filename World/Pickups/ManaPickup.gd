extends Area2D
class_name ManaPickup

@export var mana_on_pickup : float = 30

func _ready():
	GlobalInfo.world_state_changed.connect(pickup_activation)
	GlobalInfo.room_change.connect(clear_pickup)
	self.visible = false


func pickup_activation(val):
	if val:
		self.monitoring = true
		self.visible = true
	else:
		self.monitoring = false
		self.visible = false

func _on_body_entered(body):
	PlayerStats.mana += mana_on_pickup
	queue_free()

func clear_pickup(val):
	queue_free()
