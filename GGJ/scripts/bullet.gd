extends Node2D

class_name Bullet

var bulletList = []

var speed = Vector2.ZERO
var timelife = -1
var timealive = 0
var emittor

func _draw():
	draw_rect(Rect2(0, 0, 10, 10), Color(255, 0, 0))

func _process(delta):
	position += speed * delta
	
	if timelife != -1:
		timealive += delta
		if timealive > timelife:
			self.queue_free()
	
	if len(bulletList) > 10:
		bulletList[0].queue_free()
		bulletList.remove(0)

func _on_hitbox_body_entered(body):
	if !(body is emittor):
		body.Collision(self)
		self.speed = Vector2.ZERO
		$hitbox.queue_free()
