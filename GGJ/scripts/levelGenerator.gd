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

export var slimePath1 = "res://"
export var slimePath2 = "res://"
export var blobPath1 = "res://"
export var bossPath1 = "res://"
onready var slimes = [load(slimePath1), load(slimePath2), load(blobPath1), load(bossPath1)]

var wallSize = Vector2(20, 20)

var gridList = []
var mapList = {}

var objList = []

func _ready():
	wallSize *= 2
	spritesInRow = int(screenW / wallSize.x)
	spritesInCol = int(screenH / wallSize.y) 
	loadLevels()

func Generate(level_name):
	
	for a in objList:
		if is_instance_valid(a):
			a.queue_free()
	
	gridList = []
	objList = []
	
	gridList = normalizeGrid(mapList[level_name])
	
	for j in range(spritesInCol):
		for i in range(spritesInRow):
			if gridList[j][i] == 1:
				InstiateWall(Vector2(i * wallSize.x, j * wallSize.y) + wallSize/2)

			elif gridList[j][i] > 1:
				InstiateSlime(Vector2(i * wallSize.x, j * wallSize.y) + wallSize/2, gridList[j][i])

func InstiateWall (pos):
	var a = wall.instance()
	a.position = pos
	a.size = wallSize
	call_deferred("add_child_fast", a)
	
	objList.append(a)
	return a

func add_child_fast(a):
	get_parent().add_child(a)

func InstiateSlime (pos, type):
	var a = slimes[type - 2].instance()
	a.position = pos
	call_deferred("add_child_fast", a)
	get_parent().nbEnemy += 1
	
	if type - 2 > 1:
		 a.playerPath = "../player"
		 a._ready()
	objList.append(a)
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
