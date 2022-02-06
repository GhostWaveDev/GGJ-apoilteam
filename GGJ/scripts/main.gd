extends Node2D

var bulletList = []
var nbEnemy = 0

export var generatorPath = "res://"
onready var generatorScene = load(generatorPath)

onready var player = get_node("player")
var generator
var fade_out = false
var fade_counter = 0

onready var door1 = $door
onready var door2 = $door2
onready var door3 = $door3
onready var sprite = $sprite
onready var sprite_up = $sprite_up

var currentlvl = 0
var levelList = ["Start_level", "Next_level", "Cross_level", "Side1", "Side2", "Corridor", "Boss1", "Boss2"]
var imageList = [
[preload("res://sprites/enviro/room_u0.png"), preload("res://sprites/enviro/room_u1.png")], 
[preload("res://sprites/enviro/room_u0.png"), preload("res://sprites/enviro/room_u1.png")], 
[preload("res://sprites/enviro/croix0.png"), preload("res://sprites/enviro/croix1.png")],
[preload("res://sprites/enviro/room_r0.png"), preload("res://sprites/enviro/room_r1.png")],
[preload("res://sprites/enviro/room_l0.png"), preload("res://sprites/enviro/room_l1.png")],
[preload("res://sprites/enviro/couloir_h0.png"), preload("res://sprites/enviro/couloir_h1.png")],
[preload("res://sprites/enviro/tree_foreground.png"), preload("res://sprites/enviro/treebw.png")],
[preload("res://sprites/enviro/boss0.png"), preload("res://sprites/enviro/boss1.png")]
]

var dimensionSound = [preload("res://sound/dim3.mp3"), preload("res://sound/dim2.mp3"), preload("res://sound/dim1.mp3")]

var doorList = [
[1, -9, -9],
[1, -9, -9],
[3, 1, 2],
[-9, -9, -1],
[-9, -2, -9],
[1, -9, -9],
[1, -9, -9],
[-9, -9, -9]
]

var doorPosition = [
[Vector2(935, 71), Vector2(90, 540), Vector2(1830, 540)],
[Vector2(935, 71), Vector2(90, 540), Vector2(1830, 540)],
[Vector2(957, 69), Vector2(425, 577), Vector2(1538, 579)],
[Vector2(935, 71), Vector2(90, 540), Vector2(1830, 540)],
[Vector2(935, 71), Vector2(90, 540), Vector2(1830, 540)],
[Vector2(957, 69), Vector2(90, 540), Vector2(1538, 579)],
[Vector2(957, 69), Vector2(90, 540), Vector2(1538, 579)],
[Vector2(957, 69), Vector2(90, 540), Vector2(1538, 579)]
]

var doors = []

func _ready():
	generator = generatorScene.instance()
	self.add_child(generator)
	doors = [door1, door2, door3]
	fade_counter = 1
	LoadLevel(0, -1)

func _process(delta):
	if fade_out:
		fade_counter += delta
		$canvasLayer/textureRect.material.set_shader_param("time_d", fade_counter)
	if !fade_out and fade_counter > 0:
		fade_counter -= delta
		$canvasLayer/textureRect.material.set_shader_param("time_d", fade_counter)
	
	if Input.is_action_just_pressed("right_click"):
		$dimension.stream = dimensionSound[randi() % len( dimensionSound)]
		$dimension.play()

func LoadLevel(level_name, id):
	
	for child in get_children():
		if child is Bullet:
			child.queue_free()
	
	fade_out = true
	
	yield(get_tree().create_timer(1), "timeout")
	fade_out = false
	
	currentlvl += level_name
	generator.Generate(levelList[currentlvl])
	
	var b = player.position - Vector2(1980/2, 1080/2)
	player.position -= b*2
	
	var sig = 650
	
	if player.position.x > 1920 - sig:
		player.position.x = 1920 - sig
	if player.position.x <  sig:
		player.position.x = sig
	
	print("CURRENT LEVEL : " + str(currentlvl))
	sprite.cursed = [imageList[currentlvl][0], imageList[currentlvl][1]] 
	sprite.reload()
	
	if len(imageList[currentlvl]) > 2:
		sprite_up.texture = imageList[currentlvl][2]
	
	for i in range(len(doors)):
		doors[i].level_mod = doorList[currentlvl][i]
		doors[i].position = doorPosition[currentlvl][i]
		doors[i].isOpen = false
	
	player.health = 100

func _on_music_finished():
	yield(get_tree().create_timer(5), "timeout")
	$music.stream = load("res://music/combat.mp3")
	$music.play()
