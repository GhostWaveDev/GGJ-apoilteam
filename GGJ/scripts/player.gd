extends Actor

class_name Player

var speed = Vector2.ZERO
export var accel = Vector2(400,400)
var input = Vector2.ZERO
export var friction = Vector2(0.92,0.92)

func _physics_process(delta):
	input = Vector2.ZERO
	if Input.is_action_pressed("upDirec") :
		input.y += -1
	if Input.is_action_pressed("downDirec") :
		input.y += 1
	if Input.is_action_pressed("leftDirec") :
		input.x += -1
	if Input.is_action_pressed("rightDirec") :
		input.x += 1
	
	speed += accel * delta * input
	speed *= friction
	self.move_and_collide(speed * delta)
	update()

func _draw():
	draw_rect(Rect2(0,0, 10, 10), Color.red)
