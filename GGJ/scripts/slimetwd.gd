extends Enemy

var compt = 0
var jumpCooldown = 2
var jumpTime = 0
export var jumpAccel = Vector2(900, 900)
var jumpFriction = 0.9
var theta
var dir = Vector2.ZERO
var jumpSound = preload("res://sound/blob.mp3")

export var playerPath = "./"
var player

func _ready():
	player = get_node(playerPath)
	hurt = load("res://sound/blob2.mp3")

func _physics_process(delta):
	if state == 0:
		sprite.scale = Vector2(0.25, 0.25)
		if compt > jumpCooldown:
			jumpTime = 1.8
			compt = 0
			theta = -self.global_position.angle_to_point(player.global_position)
			sprite.animation = "jump"
			play_sound(jumpSound)
		
		compt += delta
		
		if jumpTime > 0:
			jumpTime -= delta
			speed += delta * jumpAccel * Vector2(-cos(theta), sin(theta))
		
		else:
			sprite.animation = "idle"
		
		speed *= jumpFriction
		move_and_slide(speed)
	
	
	update()
	print(state)
	if Input.is_action_just_pressed("right_click"):
		
		if state == 0:
			state = 1
			sprite.modulate = Color(0.4, 0.4, 0.4)
			yield(get_tree().create_timer(0.5), "timeout")
			sprite.scale = Vector2(0.5, 0.5)
			sprite.position.x += 15
			sprite.animation = "statue"
			yield(get_tree().create_timer(0.5), "timeout")
			sprite.modulate = Color(1, 1, 1)
		
		elif state == 1:
			sprite.modulate = Color(0.4, 0.4, 0.4)
			yield(get_tree().create_timer(0.5), "timeout")
			sprite.position.x -= 15
			sprite.animation = "idle"
			sprite.scale = Vector2(0.25, 0.25)
			yield(get_tree().create_timer(0.5), "timeout")
			sprite.modulate = Color(1, 1, 1)
			state = 0
			compt = 0
			jumpCooldown = 2
			jumpTime = 0
