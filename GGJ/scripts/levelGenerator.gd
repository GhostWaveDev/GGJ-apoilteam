extends Node2D

class_name LevelGenerator

var screenW = 1920
var screenH = 1080
var spritesInRow = 0
var spritesInCol = 0
var i = 0
var j = 0

var mousePos = Vector2.ZERO

export var wallPath = "res://"
onready var wall = load(wallPath)

var wallSize = Vector2(20, 20)

var gridList = []

func _ready():
	print(OS.get_screen_size())
	wallSize *= 2
	spritesInRow = int(screenW / wallSize.x)
	spritesInCol = int(screenH / wallSize.y) 
	print(spritesInRow)
	print(spritesInCol)
	
func _process(delta):
	if Input.is_action_just_pressed("draw") :
		mousePos = get_global_mouse_position()
		AddWallOnClick(mousePos)

func Generate():
#	for count in range(spritesInCol * spritesInRow):
#		i = count%spritesInRow
#		j = (count - i) / spritesInRow
#
#		if i == 0 or i == spritesInRow-1 or j == 0 or j == spritesInCol-1:
#			InstiateWall(Vector2(i * wallSize.x + wallSize.x/2 , j * wallSize.y + wallSize.y/2))
#			gridList.append(1)
#		else:
#			gridList.append(0)
	
	for i in range(spritesInCol):
		var row = []
		for j in range(spritesInRow):
			if i == 0 or j == 0 or i == spritesInCol-1 or j == spritesInRow-1:
				InstiateWall(Vector2(j * wallSize.x, i * wallSize.y) + wallSize/2)
				row.append(1)
			else:
				row.append(0)
		
		gridList.append(row)


func AddWallOnClick (pos):
	i = int(pos.x / wallSize.x)
	j = int(pos.y / wallSize.y)
	
	InstiateWall(Vector2(i * wallSize.x, j * wallSize.y) + wallSize/2)
	print(gridList)
	gridList[j][i] = 1

func InstiateWall (pos):
	var a = wall.instance()
	a.position = pos
	a.size = wallSize
	get_parent().add_child(a)
