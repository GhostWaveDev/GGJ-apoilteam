extends Node2D

var bulletList = []
var nbEnemy = 0

export var generatorPath = "res://"
onready var generatorScene = load(generatorPath)

onready var player = get_node("player")
var generator
var fade_out = false
var fade_counter = 0

func _ready():
	generator = generatorScene.instance()
	self.add_child(generator)
	generator.Generate("Start_level")

func _process(delta):
	if fade_out:
		fade_counter += delta
		$canvasLayer/textureRect.material.set_shader_param("time_d", fade_counter)
	if !fade_out and fade_counter > 0:
		fade_counter -= delta
		$canvasLayer/textureRect.material.set_shader_param("time_d", fade_counter)

func LoadLevel (level_name):
	fade_out = true
	yield(get_tree().create_timer(1), "timeout")
	fade_out = false
	generator.Generate(level_name)
	
	var b = player.position - Vector2(1920/2, 1080/2)
	player.position -= b*2
