extends Node2D

var parent
var curPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	resetPlayer()

func resetPlayer():
	parent = get_parent()
	curPosition = Vector2i(3,0)
	var startTile = parent.get_node("Grid/Tile30")
	position = startTile.position

func move(i,j):
	var newPosition = curPosition + Vector2i(i,j)
	newPosition = newPosition.clamp(Vector2i(0,0),Vector2i(3,3))
	curPosition = newPosition
	
	var nextTile = parent.get_node("Grid/Tile%s%s"%[newPosition.x,newPosition.y])
	revealTile(nextTile)
	position = nextTile.position

	

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_A  and event.is_pressed():
			move(0,-1)
		elif event.keycode == KEY_W  and event.is_pressed():
			move(-1,0)
		elif event.keycode == KEY_S  and event.is_pressed():
			move(1,0)
		elif event.keycode == KEY_D  and event.is_pressed():
			move(0,1)

func revealTile(tile):
	tile.wall(false)
