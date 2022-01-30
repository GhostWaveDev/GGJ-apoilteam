extends Node2D

class_name Bullet

var speed = Vector2.ZERO
var timelife = 12
var timealive = 0
var alliance = "good"
var sprite

var damage = 10

func _ready():
	sprite = $animatedSprite

func _process(delta):
	position += speed * delta
	
	if timelife != -1:
		timealive += delta
		if timealive > timelife:
			self.queue_free()

func _on_hitbox_body_entered(body):
	if body.alliance != self.alliance:
		body.Collision(self)
		self.speed = Vector2.ZERO
		if body is Enemy :
			get_parent().remove_child(self)
			body.add_child(self)
			self.position = Vector2.ZERO + Vector2(rand_range(-60,60), rand_range(-20,20))
		$hitbox.queue_free()
