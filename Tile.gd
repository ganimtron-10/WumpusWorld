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
	weapon(false)
	player(false)
	red(false)

func red(val):
	$Red.visible = val

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

func weapon(val):
	$Weapon.visible = val

func moveWeapon(val):
	weapon(true)
	match val:
		"left":
			$Weapon.position = Vector2(-8,0)
			$Weapon.rotation_degrees = -90
		"right":
			$Weapon.position = Vector2(8,0)
			$Weapon.rotation_degrees = 90
		"front":
			$Weapon.position = Vector2(0,-8)
			$Weapon.rotation_degrees = 0
		"back":
			$Weapon.position = Vector2(0,8)
			$Weapon.rotation_degrees = 180
