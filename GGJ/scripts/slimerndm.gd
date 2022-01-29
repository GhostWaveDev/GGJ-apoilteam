extends Enemy

var compt = 0
var jumpCooldown = 2
var jumpTime = 0
export var jumpAccel = Vector2(900, 900)
var jumpFriction = 0.9
var theta

var dir = Vector2.ZERO

func _physics_process(delta):
	if compt > jumpCooldown:
		jumpTime = 1
		compt = 0
		theta = randf() * 2 * PI
	
	compt += delta
	
	if jumpTime > 0:
		jumpTime -= delta
		
		speed += delta * jumpAccel * Vector2(cos(theta), sin(theta))
	
	speed *= jumpFriction
	move_and_slide(speed)
	
	update()


func _draw():
	draw_rect(Rect2(0,0, 10, 10), Color.red)
