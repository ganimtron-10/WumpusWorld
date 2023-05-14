extends Node2D

var width = 4
var height = 4
var offset = 130
var neighbours = [Vector2i(0,1),Vector2i(1,0),Vector2i(0,-1),Vector2i(-1,0)]

var tile = preload("res://Tile.tscn")

func resetMap():
	for i in range(width):
		for j in range(height):
			var tile = get_node("Tile%s%s"%[i,j])
			tile.resetTile()
	get_parent().resetPlayer()
	createMap()

func _input (event):
	if event is InputEventKey and event.pressed:
		if event.keycode == 82:
			resetMap()


func _ready():
	genGround()

func genGround():
	arrangeTiles()
	createMap()

func arrangeTiles():
	for i in range(width):
		for j in range(height):
			
			var newtile = tile.instantiate()
			newtile.name = "Tile%s%s"%[i,j]
			var tilesize = 16 * newtile.scale.x + 2.5
			newtile.position = Vector2i(offset+tilesize*j,offset+tilesize*i)
			
			add_child(newtile)

func genPit(exclude,i,j):
	var tile = get_node("Tile%s%s"%[i,j])
	tile.pit(true)
	exclude.append(Vector2i(i,j))
	for c in neighbours:
		if i+c.x < width and i+c.x >= 0 and j+c.y < height and j+c.y >= 0:
			var ntile = get_node("Tile%s%s"%[i+c.x,j+c.y])
			ntile.breeze(true)

func addGold(exclude,i,j):
	var tile = get_node("Tile%s%s"%[i,j])
	tile.goldbar(true)
	exclude.append(Vector2i(i,j))
	for c in neighbours:
		if i+c.x < width and i+c.x >= 0 and j+c.y < height and j+c.y >= 0:
			var ntile = get_node("Tile%s%s"%[i+c.x,j+c.y])
			ntile.gold(true)

func addWumpus(exclude,i,j):
	var tile = get_node("Tile%s%s"%[i,j])
	tile.wumpus(true)
	exclude.append(Vector2i(i,j))
	for c in neighbours:
		if i+c.x < width and i+c.x >= 0 and j+c.y < height and j+c.y >= 0:
			var ntile = get_node("Tile%s%s"%[i+c.x,j+c.y])
			ntile.stench(true)

func checkNotIn(exclude,v):
	for e in exclude:
		if e.x == v.x and e.y == v.y:
			return false
	return true

func findPlace(width,height):
	return Vector2i(randi_range(0,width-1),randi_range(0,height-1))


func createMap():
	var exclude = [Vector2i(3,0)]
	var pos
	
	var start = get_node("Tile30")
	start.wall(false)
#	start.player(true)
	
	
	var pitNum = 3
	while pitNum > 0:
		pos = findPlace(width,height)
		if checkNotIn(exclude,pos):
			pitNum-=1
			genPit(exclude,pos.x,pos.y)
	
	while true:
		pos = findPlace(width,height)
		if checkNotIn(exclude,pos):
			addWumpus(exclude,pos.x,pos.y)
			break
	
	while true:
		pos = findPlace(width,height)
		if checkNotIn(exclude,pos):
			addGold(exclude,pos.x,pos.y)
			break

func revealAll():
	for i in range(width):
		for j in range(height):
			get_node("Tile%s%s"%[i,j]).wall(false)
	
	
