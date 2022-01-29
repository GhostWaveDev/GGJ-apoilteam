extends Node2D

var bulletList = []


func _process(delta):
	if len(bulletList) > 200:
		bulletList[0].queue_free()
		bulletList.remove(0)
