extends Actor

class_name Player

export var accel = Vector2(350,300)
var input = Vector2.ZERO
var mode = 0
var sword = false

export var friction = Vector2(0.94,0.94)

func _ready():
	knockback = 2300
	sprite = $animatedSprite

func _physics_process(delta):
	z_indexS()
	input = Vector2.ZERO
	
	if Input.is_action_just_pressed("right_click"):
		mode += 1
		mode = mode % 2
	
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
	if input.x > 0:
		sprite.scale = Vector2(0.09, 0.09)
		changeAnimation("right" + str(mode))
		sprite.flip_h = false
	elif input.x < 0:
		sprite.scale = Vector2(0.09, 0.09)
		changeAnimation("right" + str(mode))
		sprite.flip_h = true
	elif input.y < 0:
		sprite.scale = Vector2(0.18, 0.18)
		changeAnimation("up" + str(mode))
	elif input.y > 0:
		sprite.scale = Vector2(0.42, 0.42)
		changeAnimation("down" + str(mode))
	
	if input == Vector2.ZERO and !sword:
		sprite.scale = Vector2(0.3, 0.3)
		sprite.transform = sprite.transform.interpolate_with(Transform2D(0, sprite.position), 10*delta)
		changeAnimation("idle" + str(mode))
	
	sprite.speed_scale = (abs(speed.x) + abs(speed.y))/420
	if sword: sprite.speed_scale = 1
	
	if input.x != 0 :
		var angle = atan(input.y/input.x)
		sprite.transform = sprite.transform.interpolate_with(Transform2D(angle, sprite.position), 0.3 * delta)
	
	speed += accel * delta * input
	speed *= friction
	self.move_and_collide(speed * delta)
	update()

func _process(delta):
	$canvasLayer/healthBar.health = health

func _on_weapon_sword(x, dir):
	sprite.scale = Vector2(0.4, 0.4)
	sprite.animation = "attackl" + str(mode)
	
	if x:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	sprite.speed_scale = 0.25
	self.speed += -dir * Vector2(knockback, knockback) * 0.6
	sword = true

func _on_animatedSprite_animation_finished():
	if sword == true:
		sword = false

func changeAnimation(n):
	if sprite.animation != n:
		sprite.animation = n


func _on_weapon_arrow(dir):
	self.speed += dir * Vector2(knockback, knockback) * 0.1
