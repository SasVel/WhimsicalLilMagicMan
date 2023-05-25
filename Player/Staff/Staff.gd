extends RigidBody2D

@onready var sprite = $StaffSprite
@onready var gem = $StaffSprite
var gemPos

func _process(_delta):
		self.rotation = lerp_angle(rotation, rotation + self.get_angle_to(get_global_mouse_position()) + deg_to_rad(90), 0.2)
	
		var tween = create_tween()	
		tween.tween_property(sprite, "rotation", sprite.get_angle_to(get_global_mouse_position()) + deg_to_rad(20), 0.3).as_relative()
		gemPos = gem.position
