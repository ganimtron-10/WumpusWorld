extends Node2D


func _ready():
	resetTile()

func resetTile():
	gold(false)
	breeze(false)
	stench(false)
	goldbar(false)
	pit(false)
	wumpus(false)

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
