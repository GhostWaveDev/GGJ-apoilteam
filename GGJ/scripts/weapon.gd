extends Node2D

export var bulletPath = "res://"
onready var bullet = load(bulletPath)

var mousePosition = Vector2.ZERO
var current = 1

var cooldown = 1
var cooldown_counter = 0

var bow_sounds = [preload("res://sound/arc1.mp3"), preload("res://sound/arc2.mp3")]
onready var sounder = $sound

export var bulletSpeed = 1200

func _process(delta):
	mousePosition = get_global_mouse_position()
	
	if Input.is_action_just_pressed("right_click"):
		current = (current + 1) % 2

	if Input.is_action_pressed("left_click"):
		if cooldown < cooldown_counter:
			if current == 0:
				var a = bullet.instance()
				get_parent().get_parent().add_child(a)
				
				var b = (self.global_position - mousePosition) / abs(self.global_position.distance_to(mousePosition))
				
				a.position = self.global_position + (b*-100)
				a.speed = Vector2(bulletSpeed, bulletSpeed) * -b
				a.sprite.rotation = a.speed.angle() + PI/2
				
				a.alliance = "good"
				
				sounder.stream = bow_sounds[randi()%len(bow_sounds)]
				sounder.play()
			
			if current == 1:
				var a1 = bullet.instance()
				var a2 = bullet.instance()
				
				get_parent().get_parent().add_child(a1)
				get_parent().get_parent().add_child(a2)
				
				var b = (self.global_position - mousePosition) / abs(self.global_position.distance_to(mousePosition))
				
				a1.position = self.global_position + (b*-100)
				a2.position = self.global_position + (b*-140)
				a1.timelife = 0.1
				a2.timelife = 0.1
				a1.alliance = "good"
				a2.alliance = "good"
				a1.damage = 15
				a2.damage = 15
			
			cooldown_counter = 0
		
	
	cooldown_counter += delta
