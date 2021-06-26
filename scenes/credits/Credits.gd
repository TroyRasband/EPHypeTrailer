extends Control

func _ready():
	$Fade/AnimationPlayer.play("Fade_in")

func _on_Main_Menu_Button_pressed():
	get_tree().change_scene("res://scenes/main_menu/main_menu.tscn")
