extends Particles2D

var timelife = 0
var maxtime = 1

func _ready():
	self.emitting = true

func _process(delta):
	timelife += delta
	if maxtime < timelife:
		self.queue_free()
