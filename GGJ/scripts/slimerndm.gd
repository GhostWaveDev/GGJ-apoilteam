extends Enemy

var compt = 0
var jumpCooldown = 3
var jumpTime = 0
export var jumpAccel = Vector2(900, 900)
var jumpFriction = 0.9
var theta
onready var collider1 = $collisionShape
onready var collider2 = $hitbox/collisionShape
var dir = Vector2.ZERO
var jumpSound = preload("res://sound/blob.mp3")

func _physics_process(delta):
	if compt > jumpCooldown:
		play_sound(jumpSound)
		jumpTime = 1.8
		compt = randf()
		theta = randf() * 2 * PI
		sprite.animation = "jump"
		collider1.position.y = collider1.position.linear_interpolate(Vector2(0, 10*abs(sin(3))), 6*compt).y
	
	compt += delta
	
	if jumpTime > 0:
		jumpTime -= delta
		
		speed += delta * jumpAccel * Vector2(cos(theta), sin(theta))
	
	else:
		sprite.animation = "idle"
	
	speed *= jumpFriction
	move_and_slide(speed)
	update()
