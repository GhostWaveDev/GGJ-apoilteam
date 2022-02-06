extends Node2D

class_name Door

var m_position = Vector2.ZERO
var m_destination = "Next_level"
export var level_mod = 1
export var id = 0
var isOpen = false
var loading = false

onready var sound = $sound

func _process(delta):
	if get_parent().nbEnemy <= 0 and !loading:
		isOpen = true
	
	if get_parent().nbEnemy > 0:
		isOpen = false
		loading = false

func _on_hitbox_body_entered(body):
	if isOpen and body is Player and level_mod != -9:
		isOpen = false
		loading = true
		sound.play()
		get_parent().LoadLevel(level_mod, id)

