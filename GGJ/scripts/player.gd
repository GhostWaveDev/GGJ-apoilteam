extends Actor

var speed = Vector2.ZERO
export var accel = Vector2(400,400)
var input = Vector2.ZERO
export var friction = Vector2(0.9,0.9)

func _process(delta):
	if Input.is_action_just_pressed("upDirec") :
		input.y = -1
	if Input.is_action_just_pressed("downDirec") :
		input.y = 1
	if Input.is_action_just_pressed("leftDirec") :
		input.x = -1
	if Input.is_action_just_pressed("rightDirec") :
		input.x = 1
		
	if Input.is_action_just_released("upDirec") :
		input.y = 0
	if Input.is_action_just_released("downDirec") :
		input.y = 0
	if Input.is_action_just_released("leftDirec") :
		input.x = 0
	if Input.is_action_just_released("rightDirec") :
		input.x = 0
		
	speed += accel * delta * input
	position += speed * delta
	speed *= friction
	update()

func _draw():
	draw_rect(Rect2(0,0, 10, 10), Color.red)
