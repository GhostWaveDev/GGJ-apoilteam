extends Node2D


func _on_ok_Button_pressed():
	get_tree().change_scene("res://scenes/main.tscn")


func _on_cancel_Button_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")
