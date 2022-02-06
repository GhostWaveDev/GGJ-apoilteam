extends Enemy

export var playerPath = "../player"
var player

var bullet = load("res://scenes/bullet.tscn")
var bulletSpeed = 600

var slime = load("res://scenes/slimetwd.tscn")

var slime_big = load("res://scenes/blob1.tscn")

var cooldown = 2
var shoot_timer = 0
var shoot_pattern = 0

var spawnTimer = 0
var spawnCooldown = 5

func _process(delta):
	player = get_node(playerPath)
	
	if state == 1:
		spawnTimer += delta
		
		if spawnTimer > spawnCooldown:
			spawnSlime(1)
			spawnTimer = 0

	if Input.is_action_just_pressed("right_click"):
		state += 1
		state = state % 2
	
	if shoot_timer > cooldown:
		if shoot_pattern == 0:
			
			shoot_timer = -1
			
			shoot(0)
			yield(get_tree().create_timer(0.1), "timeout")
			shoot(0)
			yield(get_tree().create_timer(0.1), "timeout")
			shoot(0)
			yield(get_tree().create_timer(0.1), "timeout")
			shoot(0)
			yield(get_tree().create_timer(0.1), "timeout")
			shoot(0)
			
			shoot_timer = 0
		
		if shoot_pattern == 1:
			
			shoot_timer = -1
			
			for i in range(10):
				shoot(i-5)
				
			yield(get_tree().create_timer(0.5), "timeout")
			
			for i in range(10):
				shoot(i-5, 0.5)
			
			yield(get_tree().create_timer(0.5), "timeout")
			
			for i in range(10):
				shoot(i-5, 0.5)
			
			yield(get_tree().create_timer(1), "timeout")
			
			for i in range(60):
				shoot(i-30, 0.5)
			
			shoot_timer = 0
		
		if shoot_pattern == 2:
			
			shoot_timer = -1
			
			shoot(0)
			yield(get_tree().create_timer(0.05), "timeout")
			shoot(0)
			yield(get_tree().create_timer(0.08), "timeout")
			shoot(0)
			yield(get_tree().create_timer(0.1), "timeout")
			shoot(0)
			yield(get_tree().create_timer(0.12), "timeout")
			shoot(0)
			shoot(0)
			yield(get_tree().create_timer(0.15), "timeout")
			shoot(0)
			yield(get_tree().create_timer(0.17), "timeout")
			shoot(0)
			yield(get_tree().create_timer(0.2), "timeout")
			shoot(0)
			yield(get_tree().create_timer(0.3), "timeout")
			shoot(0)
			
			shoot_timer = 0
		
		shoot_pattern = randi() % 3
	
	if shoot_timer >= 0: shoot_timer += delta 


func spawnSlime(type):
	var a 
	if type == 1:
		a = slime.instance()
	else: a = slime_big.instance()
	
	get_parent().add_child(a)
	
	var b = (self.global_position - player.global_position) / abs(self.global_position.distance_to(player.global_position))
	
	a.position = self.global_position + (b*-200)

func shoot(mod, dam = 1):
	$animatedSprite.animation = "shoot"
	var a = bullet.instance()
	get_parent().add_child(a)
	
	var b = (self.global_position - player.global_position) / abs(self.global_position.distance_to(player.global_position))
	
	a.position = self.global_position + (b*-100)
	a.speed = Vector2(bulletSpeed, bulletSpeed) * -b * dam
	a.damage = dam
	a.sprite.rotation = a.speed.angle() + PI/2 + mod

	a.alliance = "bad"

func _on_animatedSprite_animation_finished():
	$animatedSprite.animation = "idle"
