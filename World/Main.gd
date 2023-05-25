extends Node2D

var walker

func _ready():
	walker = Walker.new(Vector2.ZERO,Rect2(Vector2(3120, -1680), Vector2(3120 * 2, 1680 * 2)), 3, 10)
	walker.load_rooms()
	walker.generate_rooms()
	


