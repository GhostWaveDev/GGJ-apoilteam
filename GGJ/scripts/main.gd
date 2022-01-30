extends Node2D

var bulletList = []
var nbEnemy = 0

export var generatorPath = "res://"
onready var generatorScene = load(generatorPath)

onready var player = get_node("player")
var generator
var fade_out = false
var fade_counter = 0

onready var door = $door
onready var sprite = $sprite
onready var sprite_up = $sprite_up

var currentlvl = 0
var levelList = ["Start_level", "Next_level", "Cross_level", "Side1", "Side2", "Corridor", "Boss1", "Boss2"]
var imageList = [[preload("res://sprites/map.png"), preload("res://sprites/MAP2.png")], 
[preload("res://sprites/map.png"), preload("res://sprites/MAP2.png")],
[preload("res://sprites/Anim/Enviro croix.png"), preload("res://sprites/Anim/enviro croix dream 2.png"), preload("res://sprites/Anim/lucioles rouges.png")]
]


func _ready():
	generator = generatorScene.instance()
	self.add_child(generator)
	generator.Generate(levelList[currentlvl])

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
	
	currentlvl += level_name
	generator.Generate(levelList[currentlvl])
	
	var b = player.position - Vector2(1920/2, 1080/2)
	player.position -= b*2
	
	sprite.cursed = [imageList[currentlvl][0], imageList[currentlvl][1]] 
	sprite.reload()
	
	if len(imageList[currentlvl]) > 2:
		sprite_up.texture = imageList[currentlvl][2]
	
	door.isOpen = false
