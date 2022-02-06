extends Sprite

var cursed = []
var a = 0

onready var sprite_up = get_node("../sprite_up")

func reload():
	self.texture = cursed[a]
	upper()

func upper():
	if a == 0:
		sprite_up.visible = false


func _process(delta):
	if Input.is_action_just_pressed("right_click"):
		a += 1
		a = a % len(cursed)
		self.texture = cursed[a]
		upper()
