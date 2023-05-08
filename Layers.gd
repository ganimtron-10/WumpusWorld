extends TileMap

var width = 10
var height = 10

var offset = Vector2i(10,10)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(width):
		for j in range(height):
			set_cell(0,offset + Vector2i(i,j),0,Vector2i(0,0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
