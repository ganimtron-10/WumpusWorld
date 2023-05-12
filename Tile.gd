extends Node2D


func _ready():
	resetTile()

func resetTile():
	wall(true)
	gold(false)
	breeze(false)
	stench(false)
	goldbar(false)
	pit(false)
	wumpus(false)
#	player(false)

func wall(val):
	$Wall.visible = val

func gold(val):
	$Gold.visible = val

func breeze(val):
	$Breeze.visible = val

func stench(val):
	$Stench.visible = val

func goldbar(val):
	$GoldBar.visible = val

func pit(val):
	$Pit.visible = val

func wumpus(val):
	$Wumpus.visible = val

func player(val):
	$Player.visible = val
