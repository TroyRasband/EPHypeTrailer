extends Control

func _on_Quit_pressed():
	get_tree().change_scene("res://scenes/main_menu/main_menu.tscn")

func _on_Retry_pressed():
	get_tree().change_scene("res://scenes/gameplay_ph/demo.tscn")
