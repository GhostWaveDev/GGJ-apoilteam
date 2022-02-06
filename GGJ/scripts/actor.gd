extends KinematicBody2D
class_name Actor

var fxScene = preload("res://scenes/fx.tscn")

export var health = 100
onready var sprite = $animatedSprite
onready var area = $area2D
export var alliance = "bad" 
var hurt_timer = 10
export var truc = 0

onready var sounder = $sound
var speed = Vector2.ZERO
export var knockback = 400
export var damage = 0
var hurt = preload("res://sound/blob2.mp3")

func Die(): 
	queue_free()
	
func ChangeWorld() :
	pass
	
func TakeDamage(damage):
	play_sound(hurt)
	health -= damage
	arrg()
	if health < 0:
		arrg()
		arrg()
		arrg()
		Die()
	
	self.modulate = Color(134, 0, 0)
	yield(get_tree().create_timer(0.2), "timeout")
	self.modulate = Color(1, 1, 1)

func Collision(obj):
	var dir = (obj.global_position - self.global_position)/abs(obj.global_position.distance_to(self.global_position))
	self.speed += -dir * Vector2(knockback, knockback)
	
	if obj.damage != 0:
		if self.alliance != obj.alliance: 
			TakeDamage(obj.damage)

func z_indexS():
	z_index = 0 + (position.y/1080) 

func play_sound(n):
	if n != null:
		sounder.stream = n
		sounder.play()

func arrg():
	var a = fxScene.instance()
	a.truc(truc)
	get_parent().add_child(a)
	a.position = self.position
