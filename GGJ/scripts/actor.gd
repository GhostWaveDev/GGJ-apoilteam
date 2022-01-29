extends Node2D
class_name Actor

var health
onready var sprite = $animatedSprite
onready var area = $area2D

func Die(): 
	pass
	
func ChangeWorld() :
	pass
	
func TakeDamage(damage):
	health -= damage

func Collision(obj):
	pass
