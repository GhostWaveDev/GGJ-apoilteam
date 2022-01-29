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
var mapList = {}

func _ready():
	wallSize *= 2
	spritesInRow = int(screenW / wallSize.x)
	spritesInCol = int(screenH / wallSize.y) 
	loadLevels()

func Generate(level_name):
	gridList = normalizeGrid(mapList[level_name])
	
	for j in range(spritesInCol):
		for i in range(spritesInRow):
			if gridList[j][i] == 1:
				InstiateWall(Vector2(i * wallSize.x, j * wallSize.y) + wallSize/2)

			elif gridList[j][i] == 2:
				InstiateSlime(Vector2(i * wallSize.x, j * wallSize.y) + wallSize/2)

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
	get_parent().nbEnemy += 1
	print(get_parent().nbEnemy)
	
	return a

func loadLevels():
	var lineContent
	var fileLine
	var file = File.new()
	file.open("res://Levels.dat", File.READ)
	file.seek(0)
	
	while true :
		fileLine = file.get_line()
		if fileLine.empty() :
			break
			
		lineContent = fileLine.rsplit(",", false, 1)
		mapList[lineContent[0]] = lineContent[1]

	file.close()
	
func normalizeGrid(line):
	var k = 0
	var biDimGrid = []
	
	for i in range(spritesInCol):
		var row = []
		for j in range(spritesInRow):
			row.append(int(line[k]))
			k += 1
		
		biDimGrid.append(row)
	
	return biDimGrid
