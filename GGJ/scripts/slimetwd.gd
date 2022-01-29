extends Enemy

var compt = 0
var jumpCooldown = 2
var jumpTime = 0
export var jumpAccel = Vector2(900, 900)
var jumpFriction = 0.9
var theta
var dir = Vector2.ZERO

export var playerPath = "./"
var player

func _ready():
	player = get_node(playerPath)

func _physics_process(delta):
	if state == 0:
		if compt > jumpCooldown:
			jumpTime = 1
			compt = 0
			theta = -self.global_position.angle_to_point(player.global_position)
			sprite.animation = "jump"
		
		compt += delta
		
		if jumpTime > 0:
			jumpTime -= delta
			speed += delta * jumpAccel * Vector2(-cos(theta), sin(theta))
		
		else:
			sprite.animation = "idle"
		
		speed *= jumpFriction
		move_and_slide(speed)
	if state  == 1:
		sprite.animation = "statue"
	update()
	
	if Input.is_action_just_pressed("right_click"):
		state = (state + 1) % 2


func _draw():
	draw_rect(Rect2(0,0, 10, 10), Color.red)
