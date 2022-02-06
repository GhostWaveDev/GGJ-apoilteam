extends Sprite

onready var player = get_node("../player")

func _process(delta):
	if get_parent().currentlvl == 6:
		self.visible = true
		self.position = player.position/10
	else:
		self.visible = false
