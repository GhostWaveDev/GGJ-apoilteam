extends Actor
class_name Enemy

var state = 0

func _ready():
	var damage = 50

func _on_hitbox_body_entered(body):
	if !(body == self):
		body.Collision(self)
