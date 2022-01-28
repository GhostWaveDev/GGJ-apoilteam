extends Node2D

var health
onready var sprite = $animatedSprite
onready var area = $area2D

func Die(): 
	pass
	
func ChangeWorld() :
	pass
	
func TakeDamage(damage):
	health -= damage
