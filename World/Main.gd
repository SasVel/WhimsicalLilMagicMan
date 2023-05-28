extends Node2D

@onready var activeRoomObj = $ActiveRoom
@onready var activeRoom = $ActiveRoom/StartRoom
var rooms = []
var pastRooms = []
@onready var player = $Player

func _ready():
	EnemyTracker.start_tracker()
	GlobalInfo.room_change.connect(change_room)
	load_rooms()

func load_rooms():
	var path = "res://World/Rooms/DungeonRooms/"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			rooms.append(load(path + fileName))
			fileName = dir.get_next()

func change_room(doorVector):
	load_next_room()
	for child in activeRoomObj.get_children():
		activeRoomObj.remove_child(child)
		
	RoomFog.clearFog = false
	activeRoomObj.add_child(activeRoom)
	set_player_position(doorVector * -1)
	
func load_next_room():
	pastRooms.append(activeRoom)
	activeRoom = rooms.pop_at(randi_range(0, rooms.size() - 1)).instantiate()

func set_player_position(doorVector):
	var door
	match doorVector:
		Vector2.UP:
			door = activeRoom.get_node("DoorObjUp")
		Vector2.DOWN:
			door = activeRoom.get_node("DoorObjDown")
		Vector2.LEFT:
			door = activeRoom.get_node("DoorObjLeft")
		Vector2.RIGHT:
			door = activeRoom.get_node("DoorObjRight")
			
	player.global_position = door.position
