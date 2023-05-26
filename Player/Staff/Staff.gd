extends StaticBody2D

@onready var sprite = $StaffSprite
@onready var gemPivot = $StaffSprite/GemPivot
@onready var gem = $StaffSprite/GemPivot/GemSprite
var gemPos

func _physics_process(delta):
		self.rotation = lerp_angle(rotation, rotation + self.get_angle_to(get_global_mouse_position()) + deg_to_rad(90), 0.2)
	
		var tween = create_tween()	
		if sprite.global_position.x > GlobalInfo.playerPos.x:
			tween.tween_property(sprite, "rotation", sprite.get_angle_to(get_global_mouse_position()) + deg_to_rad(20), 0.3).as_relative()
			sprite.flip_v = false
			gemPivot.rotation = deg_to_rad(0)
		else:
			tween.tween_property(sprite, "rotation", sprite.get_angle_to(get_global_mouse_position()) + deg_to_rad(-20), 0.3).as_relative()
			sprite.flip_v = true
			gemPivot.rotation = deg_to_rad(180)
		
		gemPos = gem.global_position

	
