extends Sprite

var cursed = [preload("res://sprites/map.png"), preload("res://sprites/MAP2.png")]
var a = 0

func _process(delta):
	if Input.is_action_just_pressed("right_click"):
		self.texture = cursed[a]
		a += 1
		a = a % len(cursed)
