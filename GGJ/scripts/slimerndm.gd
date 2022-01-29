extends "res://scripts/enemy.gd"

var compt = 0

func _ready():
	speed = Vector2(10,10)
#var angle = 0
	compt = 0

func _process(delta):
	
	if compt < delta*1 :
		position += speed
	else :
		position += Vector2(speed[0]*delta*cos(randf()*2*PI), speed[1]*delta*sin(randf()*2*PI))
		compt = 0
	compt += delta
	update()


func _draw():
	draw_rect(Rect2(0,0, 10, 10), Color.red)
