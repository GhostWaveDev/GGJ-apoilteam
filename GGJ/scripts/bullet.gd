extends Node2D

class_name Bullet

var speed = Vector2.ZERO
var timelife = 12
var timealive = 0
var alliance = "good"
var sprite

onready var hitboxBox = $hitbox/collisionShape

var damage = 10

func _ready():
	sprite = $animatedSprite

func _process(delta):
	position += speed * delta
	
	if timelife != -1:
		timealive += delta
		if timealive > timelife:
			self.queue_free()
	
	if sprite.animation == "eppe":
		sprite.rotation_degrees -= delta * 300

func _on_hitbox_body_entered(body):
	if body.alliance != self.alliance:
		body.Collision(self)
		self.speed = Vector2.ZERO
		$hitbox.queue_free()
