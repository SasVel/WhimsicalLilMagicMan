extends Node
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
var rooms = []

var roomWidth = 624
var roomHeight = 336
var roomPositions = []
var startPos = Vector2.ZERO
var walkerPos = Vector2.ZERO
var borders : Rect2
var maxStepsBeforeTurn = 2
var maxSteps

func _init(StartPos, Borders, MaxStepsBeforeTurn, MaxSteps):
	borders = Borders
	maxStepsBeforeTurn = MaxStepsBeforeTurn
	maxSteps = MaxSteps

func load_rooms():
	var path = "res://World/Rooms/DungeonRooms/"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			rooms.append(load(path + fileName))
			fileName = dir.get_next()


func generate_rooms():
	pass
