extends Node2D

class_name Door

var m_position = Vector2.ZERO
var m_destination = "Next_level"
var isOpen = false

func _process(delta):
	if get_parent().nbEnemy <= 0 :
		isOpen = true

func _on_hitbox_body_entered(body):
	if isOpen and body is Player:
		get_parent().LoadLevel(m_destination)
		isOpen = false
	
