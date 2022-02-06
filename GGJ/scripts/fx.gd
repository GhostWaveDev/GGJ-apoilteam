extends Particles2D

var timelife = 0
var maxtime = 1

var sprites = [
preload("res://sprites/particules/1.png"),
preload("res://sprites/particules/2.png"),
preload("res://sprites/particules/3.png")
]

func _ready():
	self.emitting = true

func truc(t, x = 5):
	amount = x
	if t == 3:
		t -= 1
		self.modulate = Color(255, 0, 0)
	texture = sprites[t]

func _process(delta):
	timelife += delta
	if maxtime < timelife:
		self.queue_free()
