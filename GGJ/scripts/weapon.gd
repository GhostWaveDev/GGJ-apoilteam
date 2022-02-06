extends Node2D

export var bulletPath = "res://"
onready var bullet = load(bulletPath)

var mousePosition = Vector2.ZERO
var current = 1

var cooldown = 0.3
var cooldown_counter = 0
var spread = 0.2

var bow_sounds = [preload("res://sound/bow1.mp3"), preload("res://sound/bow2.mp3"), preload("res://sound/bow3.mp3"), preload("res://sound/bow4.mp3")]
var sword_sounds = [preload("res://sound/sword.mp3"), preload("res://sound/swordhit.mp3"), preload("res://sound/sword1.mp3"), preload("res://sound/sword2.mp3")]
onready var sounder = $sound

signal sword(x, dir)
signal arrow(dir)

export var bulletSpeed = 1200

func _process(delta):
	mousePosition = get_global_mouse_position()
	
	if Input.is_action_just_pressed("right_click"):
		current = (current + 1) % 2
		
		if current == 0:
			cooldown = 0.2
		
		if current == 1:
			cooldown = 1

	if Input.is_action_pressed("left_click"):
		if cooldown < cooldown_counter:
			if current == 0:
				var a = bullet.instance()
				get_parent().get_parent().add_child(a)
				
				var b = (self.global_position - mousePosition) / abs(self.global_position.distance_to(mousePosition))
				b += Vector2(randf() * spread - (spread/2), randf() * spread - (spread/2))
				a.position = self.global_position + (b*-100)
				a.speed = Vector2(bulletSpeed, bulletSpeed) * -b
				a.sprite.rotation = a.speed.angle() + PI/2

				a.alliance = "good"
				emit_signal("arrow", b)
				
				sounder.stream = bow_sounds[randi()%len(bow_sounds)]
				sounder.play()
			
			if current == 1:
				var a1 = bullet.instance()
				var a2 = bullet.instance()
				
				get_parent().get_parent().add_child(a1)
				get_parent().get_parent().add_child(a2)
				
				var b = (self.global_position - mousePosition) / abs(self.global_position.distance_to(mousePosition))
				
				a1.position = self.global_position + (b*-140)
				a2.position = self.global_position + (b*-200)
				a1.timelife = 0.1
				a2.timelife = 0.1
				a1.alliance = "good"
				a2.alliance = "good"
				a1.damage = 20
				a2.damage =20
				a1.speed = Vector2(bulletSpeed, bulletSpeed) * -b * 0.4
				a2.visible = false
				emit_signal("sword", b.x>0, b)
				a1.visible = true
				a1.sprite.animation = "eppe"
				a1.rotation = a1.speed.angle() + PI
				a1.hitboxBox.shape = RectangleShape2D.new()
				a1.hitboxBox.shape.extents = Vector2(80, 120)
				sounder.stream = sword_sounds[randi()%len(sword_sounds)]
				sounder.play()
			
			cooldown_counter = 0
		
	
	cooldown_counter += delta
