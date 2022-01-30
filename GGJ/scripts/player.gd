extends Actor

class_name Player

export var accel = Vector2(400,400)
var input = Vector2.ZERO

export var friction = Vector2(0.92,0.92)

func _ready():
	knockback = 2300
	sprite = $animatedSprite

func _physics_process(delta):
	input = Vector2.ZERO
	
	if !get_parent().fade_out:
		if Input.is_action_pressed("upDirec") :
			input.y += -1
		if Input.is_action_pressed("downDirec") :
			input.y += 1
		if Input.is_action_pressed("leftDirec") :
			input.x += -1
		if Input.is_action_pressed("rightDirec") :
			input.x += 1
	
	# ANIMATION
	if input.y < 0:
		sprite.animation = "up"
	if input.y > 0:
		sprite.animation = "down"
	if input.x > 0:
		sprite.animation = "right"
	if input.x < 0:
		sprite.animation = "left"
	
	if input == Vector2.ZERO:
		sprite.animation  = "idle"
	sprite.speed_scale = (speed.x + speed.y)/420
	
	speed += accel * delta * input
	speed *= friction
	self.move_and_collide(speed * delta)
	update()

func _process(delta):
	$canvasLayer/healthBar.health = health

func _draw():
	draw_rect(Rect2(0,0, 10, 10), Color.red)
