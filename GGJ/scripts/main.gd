extends Node2D

export var generatorPath = "res://"
onready var generatorScene = load(generatorPath)
var generator

func _ready():
	generator = generatorScene.instance()
	self.add_child(generator)
	generator.Generate()
