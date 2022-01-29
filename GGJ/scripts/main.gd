extends Node2D

var bulletList = []

export var generatorPath = "res://"
onready var generatorScene = load(generatorPath)
var generator

func _ready():
	generator = generatorScene.instance()
	self.add_child(generator)
	generator.Generate()

func _process(delta):
	if len(bulletList) > 200:
		bulletList[0].queue_free()
		bulletList.remove(0)
