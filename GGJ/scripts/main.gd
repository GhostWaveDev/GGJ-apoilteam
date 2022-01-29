extends Node2D

var bulletList = []
var nbEnemy = 0

export var generatorPath = "res://"
onready var generatorScene = load(generatorPath)
var generator

func _ready():
	generator = generatorScene.instance()
	self.add_child(generator)
	generator.Generate("Start_level")

func LoadLevel (level_name):
	#fading effect
	generator.Generate(level_name)
