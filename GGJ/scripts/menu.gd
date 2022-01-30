extends Node2D

 
func _on_QuitButton_pressed():
	get_tree().quit()


func _on_InfoButton_pressed():
	get_tree().change_scene("res://scenes/menu_sec.tscn")


func _on_playButton_pressed():
	get_tree().change_scene("res://scenes/main.tscn")
