extends Control

var health = 30.0
var max_health = 100.0
var grey_health = 0.0

var width = 400

func setHealth(n):
	health = n

func loseHealth(n):
	health -= n
	grey_health += n

func _ready():
	self.rect_global_position = Vector2(10, 10)
	$black.rect_size.x = width

func _process(delta):
	$green.rect_size.x = lerp($green.rect_size.x, (health/max_health)*width, delta * 10)
	$red.rect_size.x = lerp($red.rect_size.x, (health)/max_health*width, delta * 5)
