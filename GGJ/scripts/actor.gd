extends KinematicBody2D
class_name Actor

var fxScene = preload("res://scenes/fx.tscn")

export var health = 100
onready var sprite = $animatedSprite
onready var area = $area2D
export var alliance = "bad" 
var hurt_timer = 10

var speed = Vector2.ZERO
export var knockback = 400
export var damage = 0

func Die(): 
	queue_free()
	
func ChangeWorld() :
	pass
	
func TakeDamage(damage):
	health -= damage
	var a = fxScene.instance()
	
	self.add_child(a)
	if health < 0:
		Die()

func Collision(obj):
	var dir = (obj.global_position - self.global_position)/abs(obj.global_position.distance_to(self.global_position))
	self.speed += -dir * Vector2(knockback, knockback)
	
	if obj.damage != 0:
		if self.alliance != obj.alliance: 
			TakeDamage(obj.damage)
