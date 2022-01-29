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

export var slimePath = "res://"
onready var slime = load(slimePath)

var wallSize = Vector2(20, 20)

var gridList = []
var objList = []

func _ready():
	wallSize *= 2
	spritesInRow = int(screenW / wallSize.x)
	spritesInCol = int(screenH / wallSize.y) 
#	print(spritesInRow)
#	print(spritesInCol)
	
func _process(delta):
	if len(gridList) >0:
		if Input.is_action_just_pressed("draw") :
			mousePos = get_global_mouse_position()
			ChangeObjOnClick(mousePos, 1)
			
		if Input.is_action_just_pressed("remove") :
			mousePos = get_global_mouse_position()
			ChangeObjOnClick(mousePos, 0)
			
		if Input.is_action_just_pressed("slime") :
			mousePos = get_global_mouse_position()
			ChangeObjOnClick(mousePos, 2)

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
		var rowObj = []
		for j in range(spritesInRow):
			if i == 0 or j <= 3 or i >= spritesInCol-2 or j >= spritesInRow-4:
				rowObj.append(InstiateWall(Vector2(j * wallSize.x, i * wallSize.y) + wallSize/2))
				row.append(1)
			else:
				row.append(0)
				rowObj.append(null)
		
		gridList.append(row)
		objList.append(rowObj)

func ChangeObjOnClick (pos, mode):
	i = int(pos.x / wallSize.x)
	j = int(pos.y / wallSize.y)
	
	var objPos = Vector2(i * wallSize.x, j * wallSize.y) + wallSize/2
	if gridList[j][i] != 1 and mode == 1:
		objList[j][i] = InstiateWall(objPos)
		gridList[j][i] = 1

	elif gridList[j][i] == 0 and mode == 2 :
		objList[j][i] = InstiateSlime(objPos)
		gridList[j][i] = 2

	elif gridList[j][i] != 0 and mode == 0 :
		gridList[j][i] = 0
		objList[j][i].queue_free()

func InstiateWall (pos):
	var a = wall.instance()
	a.position = pos
	a.size = wallSize
	get_parent().add_child(a)
	
	return a

func InstiateSlime (pos):
	var a = slime.instance()
	a.position = pos
	get_parent().add_child(a)
	
	return a
