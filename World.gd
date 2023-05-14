extends Node2D


var curPosition
var currentTile
var inputPaused = false
var _score = 1000
var foundGold = false
var usedKnife = false
@onready var MessageBox = get_node("BottomInfo/Name/DeadMessage")

# Called when the node enters the scene tree for the first time.
func _ready():
	resetPlayer()

func resetPlayer():
	curPosition = Vector2i(3,0)
	var startTile = get_node("Grid/Tile30")
	startTile.player(true)
	currentTile = startTile
	MessageBox.visible = false
	inputPaused = false
	foundGold = false
	usedKnife = false
	_score = 1000
	updateScore()

func move(i,j):
	var newPosition = curPosition + Vector2i(i,j)
	newPosition = newPosition.clamp(Vector2i(0,0),Vector2i(3,3))
	
	if curPosition != newPosition:
		_score -= 1
		updateScore()
	
	curPosition = newPosition
	
	var nextTile = get_node("Grid/Tile%s%s"%[newPosition.x,newPosition.y])
	changeTile(nextTile)

func changeTile(tile):
	currentTile.player(false)
	currentTile.weapon(false)
	tile.player(true)
	if foundGold:
		currentTile.goldbar(false)
		tile.goldbar(true)
	currentTile = tile
	
	if foundGold and tile.name == "Tile30":
		updateMessageBox("You Won!🥳")
		
	# reveal wall
	tile.wall(false)
	# check if pit or Wumpus
	if tile.get_node("Pit").visible or tile.get_node("Wumpus").visible:
		updateMessageBox("You Died!☠⚰")
		inputPaused = true
	
	if tile.get_node("GoldBar").visible:
		foundGold = true
	

func _input(event):
	if not inputPaused:
		if event is InputEventKey:
			if event.keycode == KEY_A  and event.is_pressed():
				move(0,-1)
			elif event.keycode == KEY_W  and event.is_pressed():
				move(-1,0)
			elif event.keycode == KEY_S  and event.is_pressed():
				move(1,0)
			elif event.keycode == KEY_D  and event.is_pressed():
				move(0,1)
			
			elif not usedKnife:
				if event.keycode == KEY_X  and event.is_pressed():
					stab()
					_score -= 10
					updateScore()
					currentTile.weapon(false)
					usedKnife = true
				elif event.keycode == KEY_I  and event.is_pressed():
					currentTile.moveWeapon("front")
				elif event.keycode == KEY_J  and event.is_pressed():
					currentTile.moveWeapon("left")
				elif event.keycode == KEY_K  and event.is_pressed():
					currentTile.moveWeapon("back")
				elif event.keycode == KEY_L  and event.is_pressed():
					currentTile.moveWeapon("right")
				
			
				

func stab():
	var temp = currentTile.get_node("Weapon").position
	var movement = Vector2i(temp.y,temp.x)/8

	var newPosition = curPosition + movement
	newPosition = newPosition.clamp(Vector2i(0,0),Vector2i(3,3))
	
	var nextTile = get_node("Grid/Tile%s%s"%[newPosition.x,newPosition.y])
	if nextTile.get_node("Wumpus").visible:
		nextTile.red(true)
		$AudioStreamPlayer2D.play()
		nextTile.get_node("Wumpus").visible = false
		

func updateScore():
	get_node("BottomInfo/Name/Score").text = "Score:\n%s"%[_score]

func updateMessageBox(msg):
	MessageBox.get_node("Message").text = msg + "\nPress R to Restart!🔁"
	MessageBox.visible = true
	$Grid.revealAll()
