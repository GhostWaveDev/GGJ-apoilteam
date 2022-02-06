extends Enemy

var compt = 0
var jumpCooldown = 2
var jumpTime = 0
export var jumpAccel = Vector2(900, 900)
var jumpFriction = 0.9
var theta
var dir = Vector2.ZERO
var jumpSound = preload("res://sound/blob.mp3")

export var playerPath = "../player"
var player

func _ready():
	player = get_node(playerPath)
	hurt = load("res://sound/blob2.mp3")

func _physics_process(delta):
	z_indexS()
	theta = -self.global_position.angle_to_point(player.global_position)
	play_sound(jumpSound)
	
	speed += delta * jumpAccel * Vector2(-cos(theta), sin(theta))
	move_and_slide(speed)
	speed *= jumpFriction
	
	sprite.flip_h = speed.x > 0
	
	if Input.is_action_just_pressed("right_click"):
		
		if state == 0:
			state = 1
			jumpAccel = Vector2(1900, 1900)
		
		elif state == 1:
			state = 0
			jumpAccel = Vector2(900, 900)
