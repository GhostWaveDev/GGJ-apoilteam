extends Actor
class_name Enemy

var speed = Vector2.ZERO
var angle = 0
var knockback = 400

func Collision(obj):
	var dir = (obj.global_position - self.global_position)/abs(obj.global_position.distance_to(self.global_position))
	self.speed += -dir * Vector2(knockback, knockback) 
